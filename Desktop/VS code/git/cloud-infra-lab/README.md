# Cloud Infrastructure Automation Lab

This project is a cloud infrastructure automation lab built around AWS, Python, boto3, and Terraform.
The goal of this project is to explore basic Infrastructure-as-Code and cloud resource automation workflows by managing AWS EC2 resources through scripts and configuration files.

## Project Overview

Cloud resources are often managed manually through the AWS Console. However, in real engineering environments, infrastructure is usually managed through code so that resources can be created, checked, modified, and reproduced in a more reliable way.

This project explores that workflow by combining:

* Python scripts for AWS resource inspection and management
* boto3 API calls for interacting with AWS EC2
* Terraform configuration files for future Infrastructure-as-Code deployment
* Basic error handling for AWS credentials and API failures

## Tech Stack

* Python
* boto3
* botocore
* AWS EC2
* Terraform
* AWS CLI

## Project Structure

```text
cloud-infra-lab/
├── scripts/
│   └── list_ec2.py
├── terraform-demo/
│   └── main.tf
├── requirements.txt
└── README.md
```

## Features

### 1. EC2 Resource Listing with boto3

The Python script uses the AWS boto3 SDK to connect to the EC2 service and retrieve information about EC2 instances in a selected AWS region.

The script currently retrieves and displays:

* EC2 instance ID
* Instance running state
* Instance type

Example output:

```text
Instance ID: i-xxxxxxxxxxxxxxxxx
State: running
Type: t2.micro
```

If no EC2 instances are found, the script prints:

```text
No EC2 instances found in this region.
```

### 2. AWS API Error Handling

The script includes basic error handling for common AWS connection issues, including:

* Missing AWS credentials
* AWS API client errors
* General boto3 or botocore errors

This helps make the script more stable and easier to debug when running in a local development environment.

### 3. Terraform IaC Workflow

The `terraform-demo` directory is reserved for Infrastructure-as-Code configuration.

Terraform can be used to define cloud resources such as:

* EC2 instances
* Security groups
* VPCs
* Subnets
* Key pairs

The intended workflow is:

```bash
terraform init
terraform plan
terraform apply
```

This allows infrastructure to be defined, reviewed, and deployed through configuration files instead of manual AWS Console operations.

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/HpanBlake/cloud-infra-lab.git
cd cloud-infra-lab
```

### 2. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 3. Configure AWS credentials

Before running the script, make sure AWS CLI credentials are configured:

```bash
aws configure
```

You will need to provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

For this project, the default region used in the script is:

```text
us-east-1
```

## Usage

Run the EC2 listing script:

```bash
python scripts/list_ec2.py
```

The script will connect to AWS EC2 and print information about existing EC2 instances in the configured region.

## How It Works

The script follows this basic workflow:

```text
Python script
    ↓
boto3 EC2 client
    ↓
AWS EC2 describe_instances API
    ↓
Parse response data
    ↓
Print instance ID, state, and instance type
```

The main boto3 API used in this project is:

```python
ec2.describe_instances()
```

This API returns EC2 instance metadata from the selected AWS region.

## Why boto3 and Terraform?

boto3 and Terraform serve different purposes in cloud automation.

boto3 is useful for script-based cloud operations, such as checking resource status, listing EC2 instances, or performing small automation tasks.

Terraform is useful for declarative infrastructure management. Instead of telling AWS each step to perform, Terraform defines the desired final state of the infrastructure.

In simple terms:

```text
boto3: Tell AWS what action to perform now.
Terraform: Define what the cloud environment should look like.
```

Using both tools helps demonstrate two important cloud engineering workflows:

* Programmatic cloud resource management
* Infrastructure-as-Code deployment

## Future Improvements

Possible improvements for this project include:

* Add command-line arguments for region selection
* Add filtering by EC2 instance state
* Add scripts to start, stop, or reboot EC2 instances
* Complete Terraform configuration for EC2 deployment
* Add Terraform security group configuration
* Add Terraform VPC and subnet configuration
* Add GitHub Actions for Terraform validation
* Add unit tests for Python scripts
* Improve README with example screenshots and sample outputs

## Learning Goals

Through this project, I practiced:

* Using Python to interact with AWS services
* Calling AWS EC2 APIs with boto3
* Handling AWS credential and API errors
* Understanding the difference between scripting and Infrastructure-as-Code
* Organizing a small cloud infrastructure automation project
* Preparing a foundation for future DevOps and cloud automation workflows

## Notes

This project is designed as a learning lab for cloud infrastructure automation.
Before running any Terraform deployment commands, always review the resources that will be created to avoid unexpected AWS charges.

Use the following command before applying infrastructure changes:

```bash
terraform plan
```

Only run `terraform apply` after carefully reviewing the planned changes.
