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
				withCredentials([usernamePassword(credentialsId: 'DockerHubCredentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
					'''
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

