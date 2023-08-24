pipeline {
    agent any

    environment {
        // Replace DOCKERHUB_CREDENTIALS with the ID of your DockerHub credentials in Jenkins
        DOCKER_CREDENTIALS = 'DockerHubCredentials'
        IMAGE_NAME = '03f1833b5e5e/nginx1-image'
        DOCKERHUB_REPO = '03f1833b5e5e' // Replace with your DockerHub username or organization name
    }

    stages {
        stage('Checkout') {
            steps {
                // This checks out your source code from the Jenkins workspace
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${IMAGE_NAME}")
                }
            }
        }
        
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    // Log in to DockerHub
                    docker.withRegistry('https://registry.hub.docker.com', "${DOCKER_CREDENTIALS}") {
                        // Push the image to DockerHub
                        docker.image("${IMAGE_NAME}").push()
                    }
                }
            }
        }
    }
}

