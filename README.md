# aws-deployment-linux-image
Docker linux image for deployment (via Bitbucket's Pipelines) to AWS

This image is based on LT Ubuntu Bionic. It helps to deploy services on AWS via SAM and AWS-CLI. This image contains above all:

* OpenJDK (ver. 8)
* Maven (latest from Ubuntu repository, ver. 3.6.3)
* nvm (ver. 0.37.2)
* Node (ver. 14.15.4)
* npm (ver. 6.14.10)
* yarn (ver. 1.22.10)
* AWS-SAM-CLI (ver. 1.18.1)
* AWS CLI (ver. 2)
