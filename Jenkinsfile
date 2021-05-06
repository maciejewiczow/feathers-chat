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
                sh script: ' docker build -f build.Dockerfile -t feathers-chat:latest .', label: 'Build docker image'
            }
        }
        stage('Test') {
            steps {
                sh script: 'docker-compose up', label: 'Start test and eslint containers'
                sh script: '''[ `docker-compose ps -q | xargs docker inspect -f '{{ .State.ExitCode }}' | grep -v '^0' | wc -l | tr -d ' '` = "0" ]''', label: 'Check container exit codes'
            }
        }
    }

    post {
        failure {
            emailext (
                attachLog: true,
                body: '$PROJECT_NAME - Build # $BUILD_NUMBER Failed. See attached logs to view the results.',
                recipientProviders: [requestor()],
                subject: '$DEFAULT_SUBJECT'
            )
        }
        success {
            emailext (
                body: '$PROJECT_NAME - Build # $BUILD_NUMBER ran successfully',
                recipientProviders: [requestor()],
                subject: '$DEFAULT_SUBJECT'
            )
        }
    }
}
