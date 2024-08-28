pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build('dockery:latest')
                }
            }
        }
        
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerpass') {
                        docker.image('dockery:latest').push('latest')
                    }
                    
                    sh 'docker rmi dockery:latest'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    docker.image('dockery:latest').pull()
                    
                    docker.run('dockery:latest', '-p 80:80')
                }
            }
        }
    }
    
    post {
        always {
            slackSend channel: '#testing', message: "Build ${env.BUILD_NUMBER}: ${currentBuild.currentResult}"
        }
    }
}
