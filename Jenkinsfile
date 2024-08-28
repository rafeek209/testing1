pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                    docker build -t rafeek123/webapp:latest .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerpass', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        docker push rafeek123/webapp:latest
                        docker rmi rafeek123/webapp:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker pull rafeek123/webapp:latest
                    docker run -d --name webappcontainer -p 80:80 rafeek123/webapp:latest
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker stop webappcontainer || true
                docker rm webappcontainer || true
            '''
        }
        success {
            slackSend(channel: "#testing", message: "Pipe succeeded", tokenCredentialId: "slackpass")
        }
        failure {
            slackSend(channel: "#testing", message: "Pipe failed", tokenCredentialId: "slackpass")
        }
    }
}
