pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockercrd') // DockerHub credentials ID
        GITHUB_CREDENTIALS = credentials('github-pat') // GitHub credentials ID
        DOCKERHUB_REPO = 'neelpatel5270/java-hello-world' // Your DockerHub repository
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-pat', url: 'https://github.com/neel5270/Practice_DevOps.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_REPO}:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push("${env.BUILD_ID}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    sh 'docker run -d --name java-hello-world -p 8080:8080 neelpatel5270/java-hello-world:latest'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                ansiblePlaybook playbook: 'ansible/playbook.yml'
            }
        }
    }
}
