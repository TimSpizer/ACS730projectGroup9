This is Our Read me file
This is project provides set for setting up 2-tier web application automation with terraform.
It contains terraform code to set-up network infrastructure, the load balancer and automatic scaling group.
prerequisites for the project is terraform and git. git for cloning the repository and terraform to run the code infrastructure.

Below is detailed step by step explanation:

Implementing the AWS Architecture with Terraform: Step-by-Step
Based on the provided screenshots, here's a comprehensive step-by-step guide to achieve the desired AWS architecture using Terraform while adhering to the specified requirements:
2. VPC Module 
main.tf:
Create the VPC with the specified CIDR blocks for each environment.
Create public and private subnets in at least two availability zones.
Create an internet gateway and attach it to the VPC.
Create a NAT gateway for private subnet access to the internet.
Configure route tables for public and private subnets.
variables.tf:
Define variables for VPC CIDR, subnet CIDRs, availability zone names, etc.
outputs.tf:
Output the VPC ID, subnet IDs, and other relevant information for use in other modules.
3. Security Groups Module 
main.tf:
Create security groups for the web servers, allowing inbound HTTP and HTTPS traffic.
Create security groups for the load balancer, allowing inbound traffic from the internet and outbound traffic to the web servers.
variables.tf:
Define variables for port numbers and protocols.
4. IAM Module
main.tf:
Create an IAM role for the EC2 instances with permissions to access S3 and any other necessary resources.
Create an IAM instance profile and associate it with the role.
5. Auto Scaling Group Module 
main.tf:
Create launch configurations for the EC2 instances, specifying the AMI, instance type, security groups, and user data for installing and configuring the web application.
Create Auto Scaling groups for each environment (dev, staging, prod) with the desired minimum and maximum number of instances and scaling policies based on CPU utilization.
variables.tf:
Define variables for the AMI ID, instance type, scaling thresholds, and other ASG parameters.
6. Environment-Specific Configurations (environments)
main.tf (for each environment):
Call the VPC, security groups, IAM, and ASG modules with the appropriate variables for each environment.
Create an Application Load Balancer (ALB) and configure listener rules for HTTP and HTTPS traffic.
Associate the ALB with the target groups of the ASGs.
Configure the S3 bucket for storing Terraform state and website images (ensure it's not public).
7. Main Terraform File (main.tf)
Call the environment-specific configurations for dev, staging, and prod environments.
8. Additional Considerations:
State Management: Use a remote backend (e.g., Terraform Cloud, S3) for storing Terraform state.
Naming Conventions and Tagging: Implement consistent naming conventions and tagging strategies for resources.
GitHub Actions: Integrate with GitHub Actions for automated code validation, security scanning, and deployments.
Terraform Modules: Utilize existing modules from the Terraform Registry when possible.
Goldfish for Security: Implement Goldfish security tools for scanning and auditing your infrastructure.
9. Testing and Validation:
Thoroughly test your Terraform code using terraform plan and terraform apply in a non-production environment.
Validate your infrastructure using tools like AWS Config and Security Hub.
By following these steps we built the desired AWS architecture with Terraform while adhering to the best practices and requirements.
