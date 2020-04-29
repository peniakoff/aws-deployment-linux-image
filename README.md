# aws-deployment-linux-image
Docker linux image for deployment (via Bitbucket's Pipelines) to AWS

This image is based on LT Ubuntu Bionic. It helps to deploy services on AWS via SAM and AWS-CLI. This image contains above all:
* OpenJDK (ver. 8)
* Maven (latest from Ubuntu repository)
* nvm (ver. 0.35.3)
* Node (ver. 12.16.3)
* Homebrew (latest)
* AWS-CLI (latest from Homebrew Formulae)