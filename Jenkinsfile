pipeline {
    agent any
    stages {
        stage('DockerHub Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Node Version and File Creation') {
            agent {
                dockerContainer {
                    image 'node:20.17.0-alpine3.20'
                    args '-v /workspace:/workspace'
                }
            }
            steps {
                script {
                    sh '''
                    node --version
                    echo "Rafeek Zakaria" > /workspace/myname.txt
                    '''
                    archiveArtifacts artifacts: 'myname.txt'
                }
            }
        }
    }
}
