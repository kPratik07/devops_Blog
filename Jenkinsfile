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
                echo 'Starting Health Check Test...'
                sh '''
                # Start test container
                docker run -d --name test-container -p 3001:80 frontend-app
                sleep 5
                
                # Use the Docker Host IP (172.17.0.1) instead of localhost
                curl -f http://172.17.0.1:3001 || (docker stop test-container && docker rm test-container && exit 1)
                
                # Cleanup
                docker stop test-container && docker rm test-container
                '''
                echo 'Test Passed Successfully!'
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