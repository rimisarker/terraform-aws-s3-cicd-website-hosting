# 🌐 Automated Static Website Hosting on AWS S3 using Terraform & GitHub Actions

This repository contains an automated DevOps pipeline to deploy a static HTML website to AWS S3. It utilizes **Terraform** for Infrastructure as Code (IaC) and **GitHub Actions** for Continuous Integration and Continuous Deployment (CI/CD).

---

## 🚀 Architecture Overview

1. **Infrastructure as Code:** Terraform provisions an AWS S3 bucket configured for static website hosting, disables public access blocks, and applies a public read policy.
2. **CI/CD Pipeline:** GitHub Actions automatically triggers on every `push` to the `main` branch, syncing local website files directly to the S3 bucket using AWS CLI.
3. **Clean Destruction:** The S3 bucket is configured with `force_destroy = true`, ensuring smooth infrastructure cleanup via Terraform without manual file deletion.

---

## 🛠️ Prerequisites

Before running this project, ensure you have:
* An **AWS Account** with an IAM User having programmatic access.
* **Terraform CLI** installed locally.
* **Git** installed and connected to your GitHub account.

---

## ⚙️ Setup and Deployment

### Step 1: Clone and Configure Infrastructure
1. Clone this repository to your local machine.
2. Open `main.tf` and update the `bucket` name to something globally unique.
3. Initialize and apply Terraform:
   ```bash
   terraform init
   terraform apply -auto-approveREADME

1.Copy the website_url provided in the outputs.

Step 2: Configure GitHub Secrets
Go to your GitHub Repository Settings -> Secrets and variables -> Actions and add the following two environment secrets:

AWS_ACCESS_KEY_ID: Your AWS IAM User Access Key.

AWS_SECRET_ACCESS_KEY: Your AWS IAM User Secret Access Key.

Step 3: Deploy the Website
Make any changes to your index.html file or add your project documentation, then push to the main branch:
git add .
git commit -m "Deploying static website via GitHub Actions"
git push origin main

GitHub Actions will automatically pick up the changes and sync your files to S3!


🗑️ Clean Up
To completely tear down the infrastructure and delete the S3 bucket along with all its containing files, run:

terraform destroy -auto-approve
