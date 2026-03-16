Architecture Diagram
User Browser
     │
Internet
     │
EC2 Instance
     │
Docker Engine
     │
 ├── WordPress Container (port 80)
 └── MySQL Container
        │
        ▼
   EBS Volume (/mnt/mysql-data)
        │
        ▼
   Backup Script
        │
        ▼
   S3 Bucket


Why is an EBS volume used for MySQL data instead of letting the container store it internally? What would happen without it?
MySQL stores important database files. If the container stored data internally, the data would be lost whenever the container was recreated or removed so iusing an EBS volume allows the database files to persist outside the container. This means that even if the container restarts or is replaced, the data remains safe on the EBS volume.

Which ports did you open in your security group, and why those specific ports? Are there any security risks with your current configuration?
port 22 and port 80. port 22 gives you ssh access to the server while port 80 gives http access.
A security risk is that port 22 is open to the internet. In production it should be restricted to specific IP addresses.


What would break if your EC2 instance crashed right now? What data would survive and what would be lost?
we will lose the container and the files in the instance and the data that will surive are the database stored in the EBS and the backsupin the s3 bucket


If this application needed to handle 100x more users, what would you change? (It is perfectly fine to say you do not know yet, but try to think it through.)
we can use a load balance to distribute traffic across the servers
