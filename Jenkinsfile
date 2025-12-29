pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Rumaisa-Malik/skillswap.git',
                    credentialsId: 'github-creds'
            }
        }

        stage('Build') {
            steps {
                sh '"C:/Program Files/Apache/apache-maven-3.9.12/bin/mvn.cmd" clean package'
            }
        }

        stage('Test') {
            steps {
                sh '"C:/Program Files/Apache/apache-maven-3.9.12/bin/mvn.cmd" test'
            }
        }

        stage('Deploy to Tomcat 10') {
            steps {
                deploy adapters: [
                    tomcat10(
                        credentialsId: 'tomcat10-creds',
                        url: 'http://localhost:8082'
                    )
                ],
                contextPath: 'skillswap',
                war: 'target/SkillSwap.war'
            }
        }
    }
}
