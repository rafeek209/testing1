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

        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    args '-v /tmp:/tmp'
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
    }

    post {
        always {
            sh '''
                docker stop my-nginx-alpine
                docker rm my-nginx-alpine 
                cat ahmed.txt
            '''
        }
    }
}
