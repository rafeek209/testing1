pipeline {
    agent any
    stages {
        stage('clone') {
            steps {
                echo 'Cloning repository...'
            }
        }
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
        stage('run') {
            steps {
                echo 'Running the application...'
            }
        }
    }
}
