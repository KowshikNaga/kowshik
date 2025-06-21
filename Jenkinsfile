pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')       // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')   // Jenkins credential ID
        AWS_DEFAULT_REGION    = 'ap-south-2'
    }

    parameters {
        string(name: 'ASG_NAME', defaultValue: 'Demos212', description: 'Auto Scaling Group Name')
        string(name: 'AZ_NAME', defaultValue: ['ap-south-2a', 'ap-south-2b', 'ap-south-2c'], description: 'Availability Zone')
        choice(name: 'ACTION', choices: ['remove', 'add'], description: 'Action to perform')
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'pip install boto3'
            }
        }

        stage('Run Python Script') {
            steps {
                sh """
                    echo "Performing \$ACTION on \$AZ_NAME in ASG \$ASG_NAME"
                    python3 manage_asg_az.py --asg-name \$ASG_NAME --az \$AZ_NAME --action \$ACTION
                """
            }
        }
    }

    post {
        failure {
            echo '❌ Pipeline failed.'
        }
        success {
            echo '✅ Operation completed successfully.'
        }
    }
}
