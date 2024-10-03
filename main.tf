pipeline {
    agent any

    environment {
        // Fetch AWS credentials from Jenkins credentials store
        AWS_ACCESS_KEY_ID = "AKIA3ISBVXA6KCV7BFWD"
        AWS_SECRET_ACCESS_KEY = "1S1sZSiMsPWQxo4TFJ2KJh3FTSopbCThSCh+RWqY"
    }

    stages {
        stage('Checkout Terraform Code') {
            steps {
                // Clone your Git repository containing the Terraform code
                git branch: 'main', url: https://github.com/KowshikNaga/kowshik.git
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform
                    sh '''
                    terraform init
                    '''
                }
            }
        }

        stage('Apply Terraform to Create EC2') {
            steps {
                script {
                    // Apply the Terraform configuration to create the EC2 instance
                    sh '''
                    terraform apply -auto-approve \
                    -var "aws_access_key=${AWS_ACCESS_KEY_ID}" \
                    -var "aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
                    '''
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        success {
            echo 'Terraform has successfully created an EC2 instance!'
        }
        failure {
            echo 'Failed to create EC2 instance.'
        }
    }
}
