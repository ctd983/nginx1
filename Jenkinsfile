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
                // Replace this with your actual check steps
                sh 'echo "Running checks"'
                sh 'docker run -d -p 8081:80 nginx1-image:latest'
                sh 'sleep 5'
                sh 'curl -I http://localhost:8081'
            }
        }
    }

    post {
        always {
            // Clean up any resources, if needed
            sh 'docker rm -f $(docker ps -a -q --filter ancestor=nginx1-image)'
            sh 'docker image rm nginx1-image'
        }
    }
}
