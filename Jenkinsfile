pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerpass'
        IMAGE_NAME = 'rafeek123/virt'
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
                        sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
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
