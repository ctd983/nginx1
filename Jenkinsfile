pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Replace this with your actual build steps for Nginx
                sh "echo "Building Nginx"'
                sh "docker build -t 03f1833b5e5e/nginx1-image .'
            }
        }

        stage('Check') {
            steps {
				script {
					// Replace this with your actual check steps
					sh "echo "Running checks""
					sh "docker run -d -p 8081:80 03f1833b5e5e/nginx1-image:latest"
					sh "sleep 5"
					try {
						// Check if NGINX is responding.
						sh "curl -I http://localhost:8081' 
					}
					catch (Exception e){
						// Stop and remove the container in case of error
						sh "docker stop $(docker ps -a -q --filter ancestor=nginx1-image)"
						sh "docker rm -f $(docker ps -a -q --filter ancestor=nginx1-image)"
						sh "docker image rm 03f1833b5e5e/nginx1-image"
						error("Failed to connect to NGINX. Error: ${e}")
					}
					sh "docker rm -f $(docker ps -a -q --filter ancestor=03f1833b5e5e/nginx1-image)"
					
                }
            }
        }
		stage('Push to Docker Hub') {
			steps {
				script {
					def imageName = "03f1833b5e5e/nginx1-image:latest"
					
					// Check if the image exists locally
					def imageExists = sh(script: "docker images -q ${imageName}", returnStatus: true) == 0
					if(!imageExists) {
						error("Image ${imageName} does not exist locally.")
					}
					
					// Log in to Docker Hub
					withCredentials([usernamePassword(credentialsId: 'DockerHubCredentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
						sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
					}
					
					// Push the image
					sh "docker push ${imageName}"
					
					// Log out from Docker Hub
					sh "docker logout"
					
					// Remove image locally. This will error out if the image is in use by a container.
					sh "docker image rm ${imageName}"
				}
			}
		}

    }
}
