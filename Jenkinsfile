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
                    // Build the Docker image using shell command
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }
        
        stage('Login to DockerHub') {
            steps {
                withCredentials([string(credentialsId: "${DOCKER_CREDENTIALS}", variable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u 03f1833b5e5e -p ${DOCKER_PASSWORD}"  // Replace 'your-dockerhub-username' with your DockerHub username
                }
            }
        }
        
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    // Push the image to DockerHub using shell command
                    sh "docker push ${DOCKERHUB_REPO}/${IMAGE_NAME}"
                }
            }
        }
    }
}

