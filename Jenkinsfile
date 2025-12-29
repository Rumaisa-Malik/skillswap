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
                    credentialsId: 'github-skillswap',
                    url: 'https://github.com/Rumaisa-Malik/skillswap.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                bat '''
                curl -u admin:admin ^
                -T target/SkillSwap.war ^
                http://localhost:8082/manager/text/deploy?path=/skillswap&update=true
                '''
            }
        }
    }
}
