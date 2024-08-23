pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }
    stages {
        stage('DockerHub Login') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', dockerpass) {
                        echo 'Logged into DockerHub successfully'
                    }
                }
            }
        }
        stage('Node Version and File Creation') {
            agent {
                docker {
                    image 'node:16'
                }
            }
            steps {
                script {
                    sh 'node --version'
                    def fileName = '/workspace/user_name.txt'
                    sh "echo 'Rafeek Zakaria' > ${fileName}"
                    archiveArtifacts artifacts: 'user_name.txt', allowEmptyArchive: true
                }
            }
        }
        stage('Run Docker Nginx Container') {
            steps {
                script {
                    sh 'docker run -d --name my-nginx -p 8080:80 nginx'
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'cat user_name.txt'
                sh 'docker stop my-nginx || true'
                sh 'docker rm my-nginx || true'
                echo "Build number: ${env.BUILD_NUMBER}"
            }
        }
    }
}
