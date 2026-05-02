pipeline {
    agent any

    stages {

        stage('Clone') {
            steps {
                git 'https://github.com/kPratik07/devops_Blog.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t blog-app .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop blog-app || true
                docker rm blog-app || true
                docker run -d -p 3000:80 --name blog-app blog-app
                '''
            }
        }
    }
}
