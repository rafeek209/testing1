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
                    ls -l /myname.txt
                '''
                // Ensure the file is archived correctly
                archiveArtifacts artifacts: 'myname.txt', allowEmptyArchive: true
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
                    sh 'cat /myname.txt'
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
