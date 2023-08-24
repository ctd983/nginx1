pipeline {
    agent any

    environment {
        // Replace DOCKERHUB_CREDENTIALS with the ID of your DockerHub credentials in Jenkins
        DOCKER_CREDENTIALS = 'DockerHubCredentials'
        IMAGE_NAME = 'nginx1-image'
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
					sh "echo 'Building Nginx'"
                    sh "docker build -t ${DOCKERHUB_REPO}/${IMAGE_NAME} ."
                }
            }
        }
        
		stage('Check') {
            steps {
				script {
					// Replace this with your actual check steps
					sh "echo 'Running checks'"
					sh "docker run -d -p 8081:80 ${DOCKERHUB_REPO}/${IMAGE_NAME}:latest"
					sh "sleep 5"
					try {
						// Check if NGINX is responding.
						sh "curl -I http://localhost:8081"
					}
					catch (Exception e){
						// Stop and remove the container in case of error
						sh "docker stop \$(docker ps -a -q --filter ancestor=${DOCKERHUB_REPO}/${IMAGE_NAME})"
						sh "docker rm -f \$(docker ps -a -q --filter ancestor=${DOCKERHUB_REPO}/${IMAGE_NAME})"
						sh "docker image rm ${DOCKERHUB_REPO}/${IMAGE_NAME}"
						error("Failed to connect to NGINX. Error: ${e}")
					}
					sh "docker rm -f \$(docker ps -a -q --filter ancestor=${DOCKERHUB_REPO}/${IMAGE_NAME})"
					
                }
            }
        }
		
		stage('Check if the image exists locally') {
			steps {
				script {
					def imageExists = sh(script: '''docker images -q $DOCKERHUB_REPO/$IMAGE_NAME''', returnStatus: true) == 0
					if (!imageExists) {
						error("Image $DOCKERHUB_REPO/$IMAGE_NAME does not exist locally.")
					}
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
					// Log out from Docker Hub
					sh "docker logout"
					// Remove image locally. This will error out if the image is in use by a container.
					sh "docker image rm ${DOCKERHUB_REPO}/${IMAGE_NAME}"
                }
            }
        }
    }
}

