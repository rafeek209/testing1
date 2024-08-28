pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerpass'
        IMAGE_NAME = 'virt'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push("${IMAGE_TAG}")
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
            }
        }
    }
}
