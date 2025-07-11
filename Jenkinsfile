pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven-3.9.10"
    }

    stages {
        stage('clone') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/ramesharpu/ABC-Technologies.git'
            }
        }
        stage('compile'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('package'){
            steps{
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            post {
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.war'
                }
            }
        }
        stage('build and deploy with ansible'){
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh '''
                        ansible-playbook ansible/playbook.yaml \
                          --extra-vars "dockerhub_username=$DOCKERHUB_USER dockerhub_password=$DOCKERHUB_PASS"
                    '''
                }
            }
        }
    }
}