pipeline {
    agent any
    stages {
        stage('Login and Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenac', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "Logging in with user: $USERNAME"
                        curl -u $USERNAME:$PASSWORD https://example.com/login
                    '''
                }
            }
        }
        stage('File Creation and Version') {
            agent {
                docker {
                    image 'node:14'
                    label 'docker'
                }
            }
            steps {
                sh 'node --version'
                sh 'echo "Rafeek Zakaria" > Raff.txt'
            }
        }
        stage('Run') {
            steps {
                echo 'Running the application...'
            }
        }
    }
}
