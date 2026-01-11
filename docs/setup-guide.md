# Setup Guide – Auto-Scaling Nginx Web Infrastructure on AWS

## Purpose of This Document
This guide documents the exact steps used to create and validate an auto-scaling web infrastructure on AWS using **Nginx**, **Auto Scaling Groups**, and an **Application Load Balancer**.

The setup was created using the **AWS Management Console** to gain a deep understanding of how individual AWS services interact in a real-world environment.

---

## Prerequisites
Before starting, ensure you have:

- An active AWS account
- Basic understanding of EC2, VPC, and Load Balancers
- IAM user with sufficient permissions:
  - EC2
  - Auto Scaling
  - ELB
  - CloudWatch
  - WAF
- SSH key pair created in AWS
- SSH client (Linux / macOS terminal or PuTTY on Windows)

---

## Step 1: Create or Select a VPC
- Use the default VPC or create a new one
- Ensure at least **two public subnets** in different Availability Zones
- Internet Gateway must be attached
- Route table should allow `0.0.0.0/0` to the Internet Gateway

> Public subnets are required because the Application Load Balancer is internet-facing.

---

## Step 2: Create a Security Group for EC2
Create a security group with the following rules:

### Inbound Rules
- HTTP (80) → Source: Load Balancer Security Group
- SSH (22) → Source: Your IP address only

### Outbound Rules
- Allow all traffic

This ensures EC2 instances are not directly exposed to the internet except for SSH access from a trusted IP.

---

## Step 3: Create a Security Group for the Load Balancer
Inbound rules:
- HTTP (80) → Source: `0.0.0.0/0`

Outbound rules:
- Allow all traffic

---

## Step 4: Create a Launch Template
1. Go to **EC2 → Launch Templates**
2. Create a new launch template
3. Select:
   - Ubuntu
   - Instance type: `t3.micro` (free-tier friendly)
4. Attach the EC2 security group created earlier
5. Select your SSH key pair

### User Data Script
Add the following script to automatically install and start Nginx:

```bash
#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>Nginx running on Instance: $INSTANCE_ID</h1>" > /var/www/html/index.html
