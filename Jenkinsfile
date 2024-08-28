pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerpass'
        IMAGE_NAME = 'webapp'
        IMAGE_TAG = 'latest'
        CONTAINER_NAME = 'webapp_container'
        SLACK_CHANNEL = '#testing'
        SLACK_CREDENTIALS_ID = 'slackpass'
        DOCKER_HUB_USER = 'rafeek123'
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerpass', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                        docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker pull ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    docker run -d --name ${CONTAINER_NAME} -p 80:80 ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} || true
            '''
        }
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}", tokenCredentialId: "${SLACK_CREDENTIALS_ID}")
        }
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", message: "Pipeline failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}", tokenCredentialId: "${SLACK_CREDENTIALS_ID}")
        }
    }
}
