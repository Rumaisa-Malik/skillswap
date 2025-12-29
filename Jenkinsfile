pipeline {
    agent any

    tools {
        maven 'Maven-3.9.12'
        jdk 'JDK-17'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/Rumaisa-Malik/skillswap.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }

        stage('Unit Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn package'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                curl -u admin:admin ^
                -T target/SkillSwap.war ^
                "http://localhost:8082/manager/text/deploy?path=/skillswap&update=true"
                '''
            }
        }
    }
}
