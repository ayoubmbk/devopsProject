pipeline {
    agent any
    stages {
        stage('Cloning Project from Git') {
            steps {
                cleanWs()
                git url: 'https://github.com/ayoubmbk/devopsProject.git'           }
        }
        stage("Build") {
            steps {
                sh "mvn compile"
            }
        }
        stage("Unit tests") {
            steps {
                sh "mvn test"
            }
        }
         stage("Static tests") {
            steps {
              sh "mvn clean verify sonar:sonar -Dsonar.projectKey=tpAchatProject -Dsonar.host.url=http://localhost:9000 -Dsonar.login=admin -Dsonar.password=Tarajjiest19"
            }
         }
        stage("clean et packaging") {
            steps {
                        sh "mvn clean package "
                    }
                }
        stage("DEPLOY with Nexus") {
            steps { 
                sh'mvn clean deploy -Dmaven.test.skip=true -Dresume=false'
            }
        }
    stage('Docker Build and Push') {
       steps {
         withDockerRegistry([credentialsId: "docker", url: ""]) {
           sh 'printenv'
           sh 'sudo docker build -t ayoubmabrouk1/ci:latest .'
           sh 'docker push ayoubmabrouk1/ci:latest '
         }
       }
     }
       stage('Cleaning up') {
            steps {
                bat "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
 post {
        always {
            echo 'I will always say Hello again!'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
    }

}