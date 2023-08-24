pipeline {
    agent any

    environment {
        // Define the image name once to ensure consistency throughout the pipeline.
        IMAGE_NAME = "03f1833b5e5e/nginx1-image:latest"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
					echo "Entering Build stage"  // This will print a message to console output
                    docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Check') {
            steps {
                script {
                    def container
                    
                    // Start the container with proper order for arguments
                    container = docker.image(IMAGE_NAME).run("-d -p 8081:80 --name nginx-check-container")

                    // Give some time for NGINX to start
                    sleep 5

                    try {
                        // Perform an HTTP check
                        def response = httpRequest "http://localhost:8081"
                        if (response.status != 200) {
                            error("Unexpected response code from NGINX: ${response.status}")
                        }
                    } catch (Exception e) {
                        error("Failed to connect to NGINX. Error: ${e}")
                    } finally {
                        // Cleanup in a finally block to ensure it always runs
                        container.stop()
                        container.rm()
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Using Docker Pipeline plugin to push
                    docker.withRegistry('https://index.docker.io/v1/', 'DockerHubCredentials') {
                        docker.image(IMAGE_NAME).push()
                    }

                    // Remove the local image after pushing
                    docker.image(IMAGE_NAME).rm()
                }
            }
        }
    }
}
