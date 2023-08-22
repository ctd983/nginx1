pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Replace this with your actual build steps for Nginx
                sh 'echo "Building Nginx"'
                sh 'docker build -t nginx1-image .'
            }
        }

        stage('Check') {
            steps {
				script {
					// Replace this with your actual check steps
					sh 'echo "Running checks"'
					sh 'docker run -d -p 8081:80 nginx1-image:latest'
					sh 'sleep 5'
					try {
						// Check if NGINX is responding.
						sh 'curl -I http://localhost:8082' 
					}
					catch (Exception e){
						// Stop and remove the container in case of error
						sh 'docker stop $(docker ps -a -q --filter ancestor=nginx1-image)'
						sh 'docker rm -f $(docker ps -a -q --filter ancestor=nginx1-image)'
						sh 'docker image rm nginx1-image'
						error("Failed to connect to NGINX. Error: ${e}")
					}
					sh 'docker rm -f $(docker ps -a -q --filter ancestor=nginx1-image)'
					sh 'docker image rm nginx1-image'
                }
            }
        }
    }

    //post {
    //    always {
    //        // Clean up any resources, if needed
    //        sh 'echo Source Code WORK WELL'
    //        sh 'docker rm -f $(docker ps -a -q --filter ancestor=nginx1-image)'
    //        sh 'docker image rm nginx1-image'
    //    }
    //}
}
