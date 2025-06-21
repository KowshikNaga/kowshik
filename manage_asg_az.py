import boto3
import argparse
import sys

autoscaling = boto3.client('autoscaling')
ec2 = boto3.client('ec2')

def get_asg_info(asg_name):
    response = autoscaling.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
    if not response['AutoScalingGroups']:
        print(f"❌ ASG '{asg_name}' not found.")
        sys.exit(1)
    return response['AutoScalingGroups'][0]

def get_subnet_info(subnet_ids):
    return ec2.describe_subnets(SubnetIds=subnet_ids)['Subnets']

def get_subnet_for_az(vpc_id, az_name):
    subnets = ec2.describe_subnets(Filters=[
        {'Name': 'vpc-id', 'Values': [vpc_id]},
        {'Name': 'availability-zone', 'Values': [az_name]}
    ])['Subnets']
    return subnets[0]['SubnetId'] if subnets else None

def update_asg(asg_name, azs, subnets):
    autoscaling.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        AvailabilityZones=azs,
        VPCZoneIdentifier=",".join(subnets)
    )

def remove_az(asg_name, az_to_remove):
    asg = get_asg_info(asg_name)
    current_azs = asg['AvailabilityZones']
    current_subnets = asg['VPCZoneIdentifier'].split(',')

    if az_to_remove not in current_azs:
        print(f"⚠️ AZ '{az_to_remove}' is not in ASG.")
        return

    subnet_details = get_subnet_info(current_subnets)
    az_subnet_map = {s['AvailabilityZone']: s['SubnetId'] for s in subnet_details}

    updated_azs = [az for az in current_azs if az != az_to_remove]
    updated_subnets = [sid for az, sid in az_subnet_map.items() if az != az_to_remove]

    if not updated_azs or not updated_subnets:
        print("❌ Cannot remove the last AZ/subnet.")
        return

    update_asg(asg_name, updated_azs, updated_subnets)
    print(f"✅ Removed AZ '{az_to_remove}' from ASG '{asg_name}'.")

def add_az(asg_name, az_to_add):
    asg = get_asg_info(asg_name)
    current_azs = asg['AvailabilityZones']
    current_subnets = asg['VPCZoneIdentifier'].split(',')

    if az_to_add in current_azs:
        print(f"✅ AZ '{az_to_add}' is already present.")
        return

    subnet_details = get_subnet_info(current_subnets)
    vpc_ids = {s['VpcId'] for s in subnet_details}
    if len(vpc_ids) != 1:
        print("❌ ASG subnets belong to multiple VPCs.")
        return

    vpc_id = vpc_ids.pop()
    new_subnet = get_subnet_for_az(vpc_id, az_to_add)

    if not new_subnet:
        print(f"❌ No subnet found in AZ '{az_to_add}' for VPC '{vpc_id}'.")
        return

    updated_azs = current_azs + [az_to_add]
    updated_subnets = current_subnets + [new_subnet]

    update_asg(asg_name, updated_azs, updated_subnets)
    print(f"✅ Added AZ '{az_to_add}' with subnet '{new_subnet}' to ASG '{asg_name}'.")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--asg-name", required=True, help="Auto Scaling Group name")
    parser.add_argument("--az", required=True, help="Availability Zone to add or remove")
    parser.add_argument("--action", choices=["add", "remove"], required=True, help="Action to perform")
    args = parser.parse_args()

    if args.action == "remove":
        remove_az(args.asg_name, args.az)
    elif args.action == "add":
        add_az(args.asg_name, args.az)

if __name__ == "__main__":
    main()
