pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerpass'  // Replace with your DockerHub credentials ID
        IMAGE_NAME = 'rafeek123/virt'  // Replace with your DockerHub username and repository name
        IMAGE_TAG = 'latest'  // Replace with your desired image tag
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Login to DockerHub
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        // Tag the Docker image
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").tag("${IMAGE_NAME}:${IMAGE_TAG}")
                        
                        // Push the Docker image
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push("${IMAGE_TAG}")
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up: delete the Docker image after pushing
                sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
            }
        }
    }
}
