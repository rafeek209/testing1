pipeline {
    agent any
    stages {
        stage('DockerHub Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenac', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Node Version and File Creation') {
            agent {
                docker {
                    image 'node:18'
                }
            }
            steps {
                script {
                    sh '''
                    node -v
                    echo "Rafeek Zakaria" > /workspace/myname.txt
                    archiveArtifacts artifacts: 'myname.txt'
                    '''
                }
            }
        }
    }
}
