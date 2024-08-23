pipeline {
    agent any
    stages {
        stage('clone') {
            steps {
                echo 'Cloning repository...'
            }
        }
        stage('DH login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenac', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
        stage('run') {
            steps {
                echo 'Running the application...'
            }
        }
    }
}
