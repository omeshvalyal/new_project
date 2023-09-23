pipeline{
    agent any

    tools {
         maven 'maven'
    }

    stages{
        stage('checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github access', url: 'https://github.com/sreenivas449/java-hello-world-with-maven.git']]])
            }
        }
        stage('build'){
            steps{
               sh 'mvn package'
            }
        }
// stage('Upload to S3') {
  //          steps {
      //          script {
    //    withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>])
        //            def s3cmd = """
          //              aws s3 cp $artifactPath s3://your-s3-bucket-name/ --recursive
            //        """
              //      sh s3cmd
                //}
            //}
        }
}
