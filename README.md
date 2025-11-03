# DevSecOps Security Automation for Terraform & Containers

## Project Overview
This project demonstrates **automated security enforcement** for both Terraform infrastructure and container images using **GitHub Actions**. Every push or pull request triggers:

 * tfsec — scans Terraform for misconfigurations  
 * Trivy — scans Docker image for vulnerabilities  

The CI pipeline **fails automatically** if security risks are detected enforcing DevSecOps “shift left” principles.

---

## Architecture
![Architecture Diagram](diagram.png)

**Flow:**
1. Developer pushes Terraform and app changes to GitHub.
2. GitHub Actions runs Terraform security scan using tfsec.
3. If IaC is secure ✅ → Docker image is built and scanned using Trivy.
4. Vulnerabilities are reported and surfaced in GitHub Security tab.
5. Code is only merged if both security scans are clean.

---

## Screenshots

### 1. Terraform Plan
Initial infrastructure provisioning plan.

![Terraform Plan](Terraform_plan.png)

---

### 2. Terraform Apply
Terraform applies changes to AWS and creates the S3 bucket.

![Terraform Apply](Terraform_apply.png)

---

### 3. AWS S3 Bucket
The demo S3 bucket created using Terraform (initially insecure for testing).

![S3 Bucket](s3_bucket.png)

---

### 4. tfsec Scan Results
tfsec detects **HIGH/MEDIUM** security issues in Terraform configuration.

![tfsec Scan Result](tfsec_scan_result.png)

---

### 5. GitHub Actions Security Scan
Pipeline fails based on security gates — catching misconfigurations early.

![GitHub Actions Scan](tsec_results.png)

---

## How It Works

1. **Terraform deploys AWS S3 bucket** used by the sample application.
2. **tfsec** automatically scans `.tf` files for security issues:
   - Public access exposure
   - Lack of encryption
   - Missing bucket policy controls
3. If vulnerabilities exist → ❌ Pipeline fails to protect infrastructure.
4. After fixing misconfigurations → ✅ tfsec passes and Trivy runs.
5. **Trivy scans Docker image** for HIGH/CRITICAL vulnerabilities.
6. Only when **both scans pass** ✅ is the pipeline allowed to continue.

---

