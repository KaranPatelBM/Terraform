# Terraform
Terraform
Terraform is an Infrastructure as Code (IaC) tool that automates cloud infrastructure deployment using configuration files.

AWS EC2
Amazon EC2 (Elastic Compute Cloud) provides virtual servers in the cloud.

# EC2 in this Project
Creates an EC2 instance to run applications.
Configures security groups to allow SSH (port 22) and app traffic (port 8563 for React).
Uses a user data script to install necessary packages and start the application.
AWS S3
Amazon S3 (Simple Storage Service) is a scalable object storage service used to host static websites.

# S3 in this Project
Creates an S3 bucket to host the React app.
Enables static website hosting with an index.html entry point.
Configures bucket policies to allow public access.
Uploads the React build/ files to S3.

# Project Structure
 terraform-aws-project/
│── main.tf                  # Defines EC2 & S3 resources
│── variables.tf              # Stores input variables
│── outputs.tf                # Outputs important resource details
│── userdata.tpl              # Script to set up EC2 after launch
│── dist/                     # React build files (to be uploaded to S3)
│── README.md                 # Project documentation

# Install Terraform & AWS CLI
Install Terraform
Install AWS CLI
Configure AWS credentials: aws configure
# Initialize Terraform
terraform init
# Plan & Apply Infrastructure
terraform plan
terraform apply -auto-approve
# Deploy React App to S3
aws s3 sync dist/ s3://your-s3-bucket-name --delete
# Outputs & Access
EC2 Public IP: http://<EC2-PUBLIC-IP>:8563
S3 Website URL: http://your-s3-bucket-name.s3-website-region.amazonaws.com/