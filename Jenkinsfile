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
                    args '-v /workspace:/workspace' // Mount volume for persistence
                }
            }
            steps {
                sh '''
                    echo "Node.js version:"
                    node --version
                    echo "Rafeek Zakaria" > /workspace/myname.txt
                    '''
            }
        }
        
        stage('Run Docker Nginx Container') {
            steps {
                sh '''
                    echo "Running Nginx container"
                    docker run -d --name nginx-container -p 8081:80 -v /workspace:/workspace nginx
                    # Display the file to confirm it's accessible
                    cat /workspace/myname.txt
                '''
            }
        }
    }
}
