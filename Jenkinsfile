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
        stage('file creation and version') {
    agent {
        docker {
            image 'node:14'
        }
    }
    steps {
        sh 'node --version'
        sh 'echo "Rafeek Zakaria" > Raff.txt'
    }
}
        stage('run') {
            steps {
                echo 'Running the application...'
            }
        }
    }
}
