pipeline {
    agent any

    stages {
        stage('Build Frontend Image') {
            steps {
                sh 'docker build -t frontend-app .'
            }
        }

       stage('Test Stage') {
            steps {
                sh '''
                docker run -d --name test-container -p 3001:80 frontend-app
                sleep 10
                curl -sS http://172.17.0.1:3001 || exit 1
                '''
            }
            post {
                always {
                    sh 'docker stop test-container && docker rm test-container || true'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                docker stop frontend-app || true
                docker rm frontend-app || true
                docker run -d -p 3000:80 --name frontend-app frontend-app
                '''
            }
        }
    }
}