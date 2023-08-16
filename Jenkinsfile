pipeline {
    agent any

    stages {

	stage('Install Docker') {
            steps {
                script {
                    // Download the Docker installation script
                    sh 'curl -fsSL https://get.docker.com -o dockerinstall'
                    
                    // Make the script executable
                    sh 'chmod +x dockerinstall'
                
		    // Run the installation script in a Docker container with elevated privileges
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/workspace ubuntu bash -c "cd /workspace && ./dockerinstall"'    
                }
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Building Nginx"'
                sh 'docker build -t nginx1-image .'
            }
        }

        stage('Check') {
            steps {
                sh 'echo "Running checks"'
                sh 'docker run nginx1-image nginx -t'
            }
        }
    }

    post {
        always {
            // Clean up any resources, if needed
            sh 'docker rm $(docker ps -a -q --filter ancestor=nginx1-image)'
            sh 'docker image rm nginx1-image'
        }
    }
}

