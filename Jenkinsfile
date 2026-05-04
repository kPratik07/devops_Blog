pipeline {
    agent any

    stages {
        // The "Clone" stage is removed because Jenkins handles 'checkout scm' automatically
        
        stage('Build Docker Image') {
            steps {
                // Building the image using the Dockerfile in your repo
                sh 'docker build -t blog-app .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                # Stop and remove the container if it's already running to avoid name conflicts
                docker stop blog-app || true
                docker rm blog-app || true
                # Run the new container
                docker run -d -p 3000:80 --name blog-app blog-app
                '''
            }
        }
    }
    
    post {
        success {
            echo 'Deployment successful! Access your app at http://<EC2-IP>:3000'
        }
        always {
            // Optional: Clean up unused images to save EC2 disk space
            sh 'docker image prune -f'
        }
    }
}