# eks-provisions-by-terrafrom
## Introduction

This repository demonstrates provisioning infrastructure using Terraform, a declarative configuration language called HCL (HashiCorp Configuration Language). Terraform is open-source and can interact with multiple cloud providers, unlike provider-specific IaC tools like AWS CloudFormation.

## Prerequisites

To get started, ensure you have the following:
- AWS account
- AWS CLI
- Terraform
- Visual Studio Code
- eksctl

## Objectives

The main objectives of this project are:
- Setup AWS credentials
- Create an EKS cluster using Terraform
- Configure a remote backend
- Modularize Terraform code
- Implement state locking using DynamoDB
- Clean up resources

## AWS Credentials Setup

Before configuring AWS credentials, ensure AWS CLI is installed. Refer to the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) for instructions based on your operating system.

To configure AWS credentials, use the following command:
```bash
aws configure
```

## Modularizing Terraform Code

Most organizations modularize Terraform code to:
- Avoid redundancy and improve efficiency
- Enhance reusability of infrastructure components
- Improve accessibility for collaboration and management
- Maintain clean and structured codebases

### File Structure

To modularize the code, create the following directory structure:
```
root/
├── backend/
├── modules/
│   ├── EKS/
│   └── VPC/
```

## Remote Backend Setup

### Why Use AWS Remote Backend?

Using AWS Remote Backend provides:
- **Collaboration**: Multiple engineers can access the same state file.
- **Disaster Recovery**: Remote backups ensure state is not lost.
- **State Locking**: Prevents simultaneous updates using DynamoDB.

### State Locking with DynamoDB

AWS State Locking ensures only one Terraform process can modify the state file at a time, preventing conflicts and corruption.

### Prerequisites

Ensure the following are available:
- AWS account
- AWS CLI
- Terraform

Follow the steps to configure the remote backend and state locking using DynamoDB.

## Important Extensions for Productivity

Enhance your development experience with these Visual Studio Code extensions:
- [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- [GitHub Copilot](https://github.com/features/copilot)
