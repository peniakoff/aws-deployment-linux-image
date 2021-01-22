# aws-deployment-linux-image
Docker linux image for deployment (via Bitbucket's Pipelines) to AWS

This image is based on LT Ubuntu Bionic. It helps to deploy services on AWS via SAM and AWS-CLI. This image contains above all:

* OpenJDK (ver. 8)
* Maven (latest from Ubuntu repository)
* nvm (ver. 0.37.2)
* Node (ver. 14.15.4)
* Homebrew (latest)
* AWS-SAM-CLI (latest from Homebrew Formulae)
* AWS CLI version 2
