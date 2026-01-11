# AWS Auto-Scaling Nginx Web Infrastructure

## Overview
This project demonstrates a production-style, highly available, and auto-scaling web infrastructure on AWS.  
Nginx is deployed on EC2 instances managed by an Auto Scaling Group and fronted by an Application Load Balancer (ALB).  
The system automatically scales based on CPU utilization and protects against abusive or bot traffic using AWS WAF.

The project focuses on understanding real-world cloud scalability, traffic distribution, monitoring, and cost-aware infrastructure management.

---

## Architecture
The architecture is designed to handle dynamic traffic loads while maintaining high availability and security.

**Traffic Flow:**
1. User requests enter through the internet
2. AWS WAF filters malicious or high-rate requests
3. Application Load Balancer distributes traffic
4. Auto Scaling Group manages EC2 instances running Nginx
5. CloudWatch monitors metrics and triggers scaling actions

An architecture diagram is included in the `diagrams/` directory.

---

## AWS Services Used
- Amazon EC2
- Auto Scaling Group (ASG)
- Application Load Balancer (ALB)
- Target Groups
- AWS WAF (Web ACL)
- Amazon CloudWatch
- IAM
- Security Groups

---

## Key Features
- Automatic horizontal scaling based on CPU utilization
- Load-balanced traffic distribution across EC2 instances
- Bot and abusive traffic protection using AWS WAF
- Real-time monitoring and scaling using CloudWatch
- Cost-aware infrastructure lifecycle management

---

## Auto Scaling Configuration
- Minimum capacity: 1 instance  
- Desired capacity: 2 instances  
- Maximum capacity: 3 instances  
- Scale-out policy: CPU utilization > 60%  
- Scale-in policy: CPU utilization < 30%

---

## Load Testing & Validation
Auto scaling behavior was validated using the `stress` tool to generate CPU load:

```bash
stress --cpu 4 --timeout 300
