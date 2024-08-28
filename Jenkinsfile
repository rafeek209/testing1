pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerpass'
        IMAGE_NAME = 'virt'
        IMAGE_TAG = 'latest'
        CONTAINER_NAME = 'virtcon'
        SLACK_CHANNEL = 'tessting'
        SLACK_CREDENTIALS_ID = 'slackcon'
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
                        sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} rafeek123/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push rafeek123/${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker pull rafeek123/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker run -d --name ${CONTAINER_NAME} -p 80:80 rafeek123/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        always {
            script {
                sh "docker rmi rafeek123/${IMAGE_NAME}:${IMAGE_TAG} || true"
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
            }
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
    }
}
