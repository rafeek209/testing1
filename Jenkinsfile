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
                stash name: 'myname-file', includes: 'myname.txt'
            }
        }

        stage('Run Nginx Container') {
            steps {
                sh '''
                docker run -it --rm -d -p 8081:80 --name tryy nginx
                '''
            }
        }
    }

post {
    always {
        unstash 'myname-file'
        sh '''
        cat myname.txt
        docker stop tryy || true
        docker rm tryy || true
        '''
        echo "Running ${env.BUILD_ID}"
        }
    }
}
