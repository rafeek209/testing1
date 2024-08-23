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
                    echo "Rafeek Zakaria" > /myname.txt
                    '''
            }
        }
        
        stage('Run Docker Nginx Container') {
            steps {
                sh '''
                    echo "Running Nginx container"
                    docker run -d --name nginx-container -p 8080:80 nginx
                '''
            }
        }
    }
}
