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
    }
}
