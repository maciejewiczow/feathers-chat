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
                sh '''
                    docker-compose up
                    code = docker-compose ps -q | xargs docker inspect -f '{{ .State.ExitCode }}' | grep -v '^0' | wc -l | tr -d ' '
                    [ $code -neq 0 ] && exit $code
                '''
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
