pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Replace this with your actual build steps for Nginx
		sh 'echo "install docker"'
		sh 'curl https://get.docker.com > dockerinstall && chmod 777 dockerinstall && ./dockerinstall'
                sh 'echo "Building Nginx"'
                sh 'docker build -t nginx1-image .'
            }
        }
        
        stage('Check') {
            steps {
                // Replace this with your actual check steps
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

