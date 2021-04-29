pipeline {
    agent any

    stages {
        stage('Pull in changes') {
            steps {
                git branch: 'crow', url: 'https://github.com/maciejewiczow/feathers-chat'
            }
        }
        stage('Build') {
            steps {
                sh ' docker build -f build.Dockerfile -t feathers-chat:latest .'
            }
        }
        stage('Test') {
            steps {
                sh ' docker-compose up'
            }
        }
    }

    post {

    }
}
