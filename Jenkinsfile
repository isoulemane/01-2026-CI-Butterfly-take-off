pipeline {
    agent {
        docker {
            image 'your-dockerhub-username/jenkins-maven-docker:latest'
            args '-u root:root' // optional if you need root permissions
        }
    }

    environment {
        WORKSPACE_DIR = '/home/jenkins/workspace'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    if (fileExists('pom.xml')) {
                        echo "Maven project found. Running mvn package..."
                        sh 'mvn clean package'
                    } else {
                        echo "No Maven project detected. Skipping Maven build."
                    }
                }
            }
        }

        stage('Run Scripts') {
            steps {
                script {
                    def scripts = findFiles(glob: '*.sh')
                    if (scripts.length == 0) {
                        echo "No shell scripts found."
                    } else {
                        scripts.each { s ->
                            sh "chmod +x ${s.name}"
                            sh "./${s.name}"
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed. Check console output."
        }
    }
}

