# Running LabOS environment
**This tutorial includes 2 parts:**
* Creating infrastructure with following resources in AWS account using [Terraform](https://www.terraform.io/):
    * VPC
      * IGW 
      * Public subnet
        * EC2 instance
          * User data - install docker and docker-compose
          * AMI - Ubuntu 20.04 LTS 
          * Security group 
              * Ingress
                * 80 from ANY IPV4 address 
                * 22 from ANY IPV4 address
              * egress
                * ANY port to any IPV4 address
          * EC2 key pair
        * Public routing table - route to IGW
* Running the environment using [docker compose](https://docs.docker.com/compose/) command

## Terraform

Goto ```terraform``` using following command:

```shell
cd terraform
```


Create ```tfvars``` folder using following command:
```shell
mkdir tfvars
```

Create new file called ```secrets.tfvars``` in ```tfvars``` folder with following content:
```shell
aws_access_key_id = "<aws _access_key_id>"
aws_secret_access_key = "<aws_secret_access_key>"
```

Init provider and plugins using following command:

```shell
terraform init
```
Run the following command to create infrastructure in [AWS](https://aws.amazon.com/):

```shell
terraform apply -var_file=tfvars/secrets.tfvars
```

Verify that above resources will be added to the  infrastructure and after that type ```yes``` to create infrastructure:

```shell
Plan: 8 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```
If all infrastructure created successfully you will be see something like that:

```shell
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
```

## Docker compose

Connect to the ec2 instance that created by  [Terraform](https://www.terraform.io/) by running following command:

```shell
ssh -i <path_to_your_private_key_of_key_pair> ubuntu@<public_ipv4_ec2_instance> 
```

Git clone LabOS public repository using following command:

```shell
git clone https://github.com/LidorAbo/LabOS.git
```
Goto public repository docker folder by running following command:

```shell
cd LabOS/docker 
```

Run the environment by running the following command:

```shell
docker compose up
```
      
After some time you need to see the following output:

```shell
docker-nginx-1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
docker-nginx-1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
docker-nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
docker-nginx-1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
docker-nginx-1  | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
docker-nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
docker-nginx-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
docker-nginx-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: using the "epoll" event method
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: nginx/1.23.0
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: OS: Linux 5.13.0-1031-aws
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: start worker processes
docker-nginx-1  | 2022/07/06 22:43:35 [notice] 1#1: start worker process 30
docker-web-1    |  * Serving Flask app 'app' (lazy loading)
docker-web-1    |  * Environment: production
docker-web-1    |    WARNING: This is a development server. Do not use it in a production deployment.
docker-web-1    |    Use a production WSGI server instead.
docker-web-1    |  * Debug mode: off
docker-web-1    |  * Running on all addresses (0.0.0.0)
docker-web-1    |    WARNING: This is a development server. Do not use it in a production deployment.
docker-web-1    |  * Running on http://127.0.0.1:8080
docker-web-1    |  * Running on http://172.18.0.2:8080 (Press CTRL+C to quit)
```

Now, you can check if env working as expected by access to the following URI from your browser:

```shell
http://<public_ipv4_ec2_instance>/<github_repo_owner>/<github_repo_name>
```
**If all is working as expected you can see as output white page with latest release of repo that typed in the URI** 

## Cleanup

Goto ```terraform``` folder in the local machine that you created the infrastructure by running the following command:
```shell
cd terrafrom
```

Destroy the env by running the following command:

```shell
terraform destroy -var-file=tfvars/secrets.tfvars
```

Verify that above resources will be removed from the  infrastructure and after that  type ```yes``` to create infrastructure:

```shell
Plan: 0 to add, 0 to change, 8 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

```
If all infrastructure created successfully you will be see something like that:

```shell
Destroy complete! Resources: 8 destroyed.

```
