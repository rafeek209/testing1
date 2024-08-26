pipeline {
    agent any

    stages {
        stage('Login and Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerpass', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "Logging in with user: $USERNAME"
                        docker login -u "$USERNAME" --password-stdin                    '''
                }
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'node:alpine'
                }
            }
            steps {
                sh '''
                    echo "With docker"
                    echo "Ahmed shabaan" >ahmed.txt
                    node --version
                '''
            }
        }

        stage('Run Nginx Container') {
            steps {
                sh '''
                docker run -it --rm -d -p 5000:80 --name my-nginx-alpine nginx
                '''
            }
        }
    }
}
