pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockercrd') // Use your DockerHub credentials ID in Jenkins
        DOCKERHUB_REPO = 'neelpatel5270/java-hello' // Your DockerHub repository
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Checkout the repository and branch
                    try {
                        git branch: 'main', url: 'https://github.com/neel5270/EXAM.git'
                    } catch (Exception e) {
                        error "Failed to clone repository: ${e.message}"
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        docker.build("${DOCKERHUB_REPO}:latest")
                    } catch (Exception e) {
                        error "Failed to build Docker image: ${e.message}"
                    }
                }	
            }
        }
        stage('Compile and Run Java Application') {
            steps {
                script {
                    try {
                        sh 'javac src/HelloWorld.java'
                        sh 'java -cp src HelloWorld'
                    } catch (Exception e) {
                        error "Failed to compile and run Java application: ${e.message}"
                    }
                }
            }
        }
        stage('Test DockerHub Credentials') {
            steps {
                script {
                    docker.withRegistry('', 'dockercrd') {
                        echo 'DockerHub login successful'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    try {
                        docker.withRegistry('', 'dockercrd') {
                            docker.image("${DOCKERHUB_REPO}:latest").push()
                        }
                    } catch (Exception e) {
                        error "Failed to push Docker image: ${e.message}"
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    // Remove the existing container if it exists
                    sh '''
                        if [ $(docker ps -aq -f name=java-hello) ]; then
                            docker rm -f java-hello
                        fi
                    '''
                    // Start a new container
                    sh 'docker run -d --name java-hello -p 8081:8080 neelpatel5270/java-hello:latest'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    try {
                        ansiblePlaybook(
                            playbook: 'ansible/playbook.yml',
                            inventory: 'ansible/inventory',
                            colorized: true
                        )
                    } catch (Exception e) {
                        error "Failed to run Ansible playbook: ${e.message}"
                    }
                }
            }
        }
    }
}
