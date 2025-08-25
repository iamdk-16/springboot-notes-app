pipeline {
    agent {
        docker {
            image 'thedk/maven-docker:latest'
            // Mount local maven repo for dependency caching
            args '-v /root/.m2:/root/.m2'
        }
    }

    environment {
        IMAGE_NAME = "thedk/springboot-notes-app"
        IMAGE_TAG  = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/iamdk-16/springboot-notes-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build & Push successful!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}

