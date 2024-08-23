pipeline {
    agent any
    stages {
        stage('clone') {
            steps {
                #!/bin/bash
                chmod +x hello.sh
                ./Jenkinsfile
            }
        }
        stage('build') {
          agent {
            docker {
              image 'node:18-apline'
          }
            steps {
                //
            }
        }
        stage('run') {
            steps {
                //
            }
        }
    }
}
