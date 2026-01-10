pipeline {
    agent any

    tools {
        maven 'Maven-3.9.9'     // Nom configuré dans Jenkins > Global Tool Configuration
        jdk 'JDK-17'
    }

    environment {
        APP_NAME = "my-java-app"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/isoulemane/01-2026-CI-Butterfly-take-off.git'
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully'
        }
        failure {
            echo '❌ Build failed'
        }
        always {
            cleanWs()
        }
    }
}

