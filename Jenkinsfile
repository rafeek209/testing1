pipeline {
    agent any
    stages {
        stage('clone') {
            steps {
                //
            }
        }
        stage('hub login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenac', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
        stage('run') {
            steps {
                //
            }
        }
    }
}
