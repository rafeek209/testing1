pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Login and Deploy') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u rafeek123 --password-stdin
                    '''
                }
            }
        }

        stage('Build') {
            steps {
                sh '''
                    # Your build commands here
                '''
            }
        }

        stage('Run Nginx Container') {
            steps {
                sh '''
                    docker run --name nginx-container -d nginx
                '''
            }
        }
    }

    post {
        always {
            echo "Cleaning up..."
            sh 'docker rm -f nginx-container || true'
        }
    }
}
