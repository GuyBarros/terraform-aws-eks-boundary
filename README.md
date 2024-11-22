(documentation helpfully provider by our friends chatGPT (sorry) - G.)

# terraform-aws-eks-boundary

This Terraform module provisions an Amazon Elastic Kubernetes Service (EKS) cluster integrated with HashiCorp Boundary for secure access management. It automates the setup of EKS and configures Boundary to manage access to Kubernetes resources, enhancing security and simplifying access control.

## Features

- **EKS Cluster Provisioning**: Automates the creation of an EKS cluster with customizable configurations.
- **Boundary Integration**: Sets up HashiCorp Boundary to manage secure access to the EKS cluster.
- **Secure Access Management**: Utilizes Boundary's capabilities to enforce fine-grained access controls for Kubernetes resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS credentials configured for Terraform to provision resources.
- [HashiCorp Boundary](https://www.boundaryproject.io/) installed and configured.

## Usage

first deploy the EKS cluster and then deploy Boundary

1. **Clone the Repository**

   ```bash
   git clone https://github.com/GuyBarros/terraform-aws-eks-boundary.git
   cd terraform-aws-eks-boundary
   ```

2. **Navigate to the EKS Directory && Initialize Terraform**

   ```bash
   cd eks_cluster && terraform init
   ```

3. **Review and Modify Variables**
Edit the variables.tf file to customize the EKS cluster and Boundary configurations as needed.   

4. **Apply the Terraform Configuration**

   ```bash
   terraform apply
   ```

5. **Navigate to the Boundary Deployment Directory && Initialize Terraform**

   ```bash
   cd ../boundary_deployment && terraform init
   ```

6. **Review and Modify Variables**
Edit the variables.tf file to customize the EKS cluster and Boundary configurations as needed.   

7. **Apply the Terraform Configuration**

   ```bash
   terraform apply
   ```

## Contributing ## 

Contributions are welcome! If you would like to contribute:

    Fork the repository.
    Create a new branch for your feature or bugfix.
    Submit a pull request with a clear description of your changes.

## License ## 

This project is licensed under the Apache 2.0 License. See the LICENSE file for more details.
Acknowledgments

This module was inspired by the need for secure and manageable access to Kubernetes resources using HashiCorp Boundary.