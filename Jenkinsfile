pipeline {
    agent any

    stages {
		stage('Build') {
			steps {
				script {
					def imageName = "03f1833b5e5e/nginx1-image"
					// Assuming the Dockerfile is in the root of the workspace
					def dockerfile = docker.build(imageName)
				}
			}
		}

        stage('Check') {
			steps {
				script {
					def imageName = "03f1833b5e5e/nginx1-image:latest"
					def container
		
					// Start the container
					container = docker.run("--name nginx-check-container -d -p 8081:80", imageName)
		
					// This "sleep" is to give NGINX some time to start up.
					// It's not the most reliable method, but alternatives would likely also involve sh steps or external tools.
					sleep 5
		
					// Check if NGINX is responding using httpRequest
					try {
						// Assuming you've the HTTP Request plugin installed
						def response = httpRequest "http://localhost:8081"
						if (response.status != 200) {
							error("Unexpected response code from NGINX: ${response.status}")
						}
					} catch (Exception e) {
						// Handle any exceptions during the request
						container.stop()
						docker.image(imageName).rm()
						error("Failed to connect to NGINX. Error: ${e}")
					}
		
					// Cleanup
					container.stop()
					container.rm()
				}
			}
		}

		stage('Push to Docker Hub') {
			steps {
				script {
					def imageName = "03f1833b5e5e/nginx1-image:latest"
					
					// Using Docker Pipeline plugin for some operations
					docker.withRegistry('https://index.docker.io/v1/', 'DockerHubCredentials') {
						
						// The next step ensures the image exists locally
						def image = docker.image(imageName)
						
						// This will throw an error if the image doesn't exist locally.
						// No need for a separate check.
						image.push()
					}
					
					// If you still wish to remove the image locally after pushing:
					docker.image(imageName).rm()
				}
			}
		}
	}
}
