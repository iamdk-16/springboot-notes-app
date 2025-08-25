pipeline {
    agent {
        docker {
            image 'thedk/maven-docker:latest'
            // mount local maven repo for caching dependencies
            args '-v /root/.m2:/root/.m2'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                // get code from your repo
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
                    sh "docker build -t thedk/springboot-notes-app:latest ."
                }
            }
        }

        stage('Push Docker Image') {
    steps {
        script {
            docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                docker.image('thedk/springboot-notes-app:latest').push()
            }
        }
    }
}

