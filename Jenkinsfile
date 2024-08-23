pipeline {
    agent any
    stages {
        stage('DockerHub Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerpass', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "Logging in to DockerHub with user: $USERNAME"
                        echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Node Version and File Creation') {
            agent {
                docker {
                    image 'node:alpine'
                }
            }
            steps {
                sh '''
                    echo "Node.js version:"
                    node --version
                    echo "Rafeek Zakaria" > myname.txt
                '''
            }
        }

        stage('Run Nginx Container') {
            steps {
                sh '''
                docker run -it --rm -d -p 8081:80 --name web nginx
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker stop web || true
                docker rm web || true
            '''
        }
    }
}
