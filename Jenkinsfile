pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AKIA3ISBVXA6P464CZO4')       // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('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')   // Jenkins credential ID
        AWS_DEFAULT_REGION    = 'ap-south-2'
    }

    parameters {
        string(name: 'ASG_NAME', defaultValue: 'Demos212', description: 'Auto Scaling Group Name')
        choice(name: 'AZ_NAME', choices: ['ap-south-2a', 'ap-south-2b', 'ap-south-2c'], description: 'Availability Zone')
        choice(name: 'ACTION', choices: ['remove', 'add'], description: 'Action to perform')
        choice(name: 'GIT_BRANCH', choices: ['main', 'dev', 'master'], description: 'Git branch to use')
    }

    stages {
        stage('Clone Repo') {
            steps {
                // Replace the Git URL with your actual repo
                git branch: "${params.GIT_BRANCH}", url: 'https://github.com/KowshikNaga/kowshik.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install boto3'
            }
        }

        stage('Run Python Script') {
            steps {
                sh """
                    echo "Branch: \$GIT_BRANCH"
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
