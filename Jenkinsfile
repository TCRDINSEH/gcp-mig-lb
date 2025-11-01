pipeline {
  agent any

  environment {
    PROJECT_ID = "applied-pager-476808-j5"
    REGION = "us-central1"
    GCP_CREDENTIALS = "serviceaccountkey"  
    GIT_CREDENTIALS = "tokenforgcpmiglb"  
  }

  stages {
       stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/TCRDINSEH/gcp-mig-lb.git',
                credentialsId: "${GIT_CREDENTIALS}"
        
            }
        }

    stage('Authenticate to GCP') {
      steps {
        withCredentials([file(credentialsId: "${GCP_CREDENTIALS}", variable: 'GCP_KEYFILE')]) {
          sh '''
            echo "🔐 Authenticating to GCP..."
            gcloud auth activate-service-account --key-file=$GCP_KEYFILE
            gcloud config set project ${PROJECT_ID}
          '''
        }
      }
    }

    stage('Terraform Init') {
      steps {
       
          withCredentials([file(credentialsId: "${GCP_CREDENTIALS}", variable: 'GCP_KEYFILE')]) {
            sh '''
              pwd 
              echo "⚙️ Initializing Terraform..."
              export GOOGLE_APPLICATION_CREDENTIALS="$GCP_KEYFILE"
              terraform init -input=false
            '''
          }
        
      }
    }

    stage('Terraform Validate') {
      steps {
              sh '''
            
            echo "✅ Validating Terraform configuration..."
            terraform validate
          '''
        }
          }

    stage('Terraform Plan') {
      steps {
        
          withCredentials([file(credentialsId: "${GCP_CREDENTIALS}", variable: 'GCP_KEYFILE')]) {
            sh '''
            
              echo "🧩 Planning GKE deployment..."
              export GOOGLE_APPLICATION_CREDENTIALS="$GCP_KEYFILE"
              terraform plan -var-file=dev_tf.tfvars
            '''
          }
        
      }
    }

    stage('Terraform Apply') {
      steps {
        
          withCredentials([file(credentialsId: "${GCP_CREDENTIALS}", variable: 'GCP_KEYFILE')]) {
           
            sh '''
              
              echo "🚀 Applying Terraform changes (creating GKE)..."
              export GOOGLE_APPLICATION_CREDENTIALS="$GCP_KEYFILE"
              terraform apply -var-file=dev_tf.tfvars --auto-approve                
            '''
          }
        
      }
    }

    stage('Verify GKE Cluster') {
      steps {
        withCredentials([file(credentialsId: "${GCP_CREDENTIALS}", variable: 'GCP_KEYFILE')]) {
          sh '''
            echo "☸️ Verifying GKE cluster..."
            gcloud auth activate-service-account --key-file=$GCP_KEYFILE
            gcloud container clusters list --project ${PROJECT_ID}
          '''
        }
      }
    }
  }

  post {
    success {
      echo "✅ Terraform successfully created GKE cluster!"
    }
    failure {
      echo "❌ Terraform pipeline failed — check logs."
    }
  }
}