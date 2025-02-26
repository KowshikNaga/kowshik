pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/KowshikNaga/kowshik.git'  // Update with correct repo URL
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
            }
        }
    }
}
