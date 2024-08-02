pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockercrd') // Use your DockerHub credentials ID in Jenkins
    }

    stages {
        stage('Test DockerHub Credentials') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockercrd') {
                        echo 'DockerHub login successful'
                    }
                }
            }
        }
    }
}
