pipeline {
  environment {
    registry = "ayoubmabrouk1/ayoubmabrouk1/ci"
    registryCredential = 'docker'
  }
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
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
 stage('Sending Mail'){
            steps{
                mail ( body: 'Congratulations! your DevOps project pipeline was completed succesfully!', subject: 'Pipeline', to: 'ayoubmabrouk65@gmail.com')
            }
        }
    }

}