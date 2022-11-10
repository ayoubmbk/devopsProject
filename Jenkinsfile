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
        success {
					
					
						emailext attachLog: true, body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:Check console output at $BUILD_URL to view the results.', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'ayoub.mabrouk@esprit.tn'
				}    
						failure {
						emailext attachLog: true, body: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:Check console output at $BUILD_URL to view the results.', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'ayoub.mabrouk@esprit.tn'
				} 
				//}

}