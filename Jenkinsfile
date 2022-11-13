pipeline {
  environment {
    registry = "ayoubmabrouk1/achat:latest"
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
       stage('Nexus'){
               steps{
                   nexusArtifactUploader artifacts: [[artifactId: 'tpAchatProject', classifier: '', file: 'target/tpAchatProject-1.0.jar', type: 'jar']],
                   credentialsId: 'nexus',
                   groupId: 'com.esprit.examen',
                   nexusUrl: '172.10.0.140:8080',
                   nexusVersion: 'nexus3',
                   protocol: 'http',
                   repository: 'Nexus-DevOps',
                   version: '1.0'
               }
           }
    stage('Docker Build and Push') {
       steps {
         withDockerRegistry([credentialsId: "docker", url: ""]) {
           sh 'printenv'
           sh 'sudo docker build -t ayoubmabrouk1/achat .'
           sh 'docker push ayoubmabrouk1/achat '
         }
       }
     }
   stage('DockerCompose') {

                          steps {

   				sh 'docker-compose up -d'
                           }

           }

 stage('Sending Mail'){
            steps{
                mail ( body: 'Congratulations! your DevOps project pipeline was completed succesfully!', subject: 'Pipeline', to: 'ayoubmabrouk65@gmail.com')
            }
        }
    }

}