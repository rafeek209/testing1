pipeline {
    agent any
    stages {
        stage('DockerHub Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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
                    image 'node:16' // Replace with the Docker image you need
                }
            }
            steps {
                sh '''
                    echo "Node.js version:"
                    node --version
                    echo "Creating file with user name"
                    echo "Rafeek Zakaria" > user_name.txt
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
    post {
        always {
            script {
                try {
                    sh 'cat user_name.txt'
                } catch (Exception e) {
                    echo "File not found or an error occurred: ${e.message}"
                }
                
                sh '''
                    echo "Stopping and removing Nginx container"
                    docker stop nginx-container || true
                    docker rm nginx-container || true
                '''
                
                echo "Build number: ${env.BUILD_NUMBER}"
            }
        }
    }
}
