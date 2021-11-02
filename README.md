# Task Terraform-Ansible-GCP

## Task 1 

## Main goals.

### Create three VMs in GCP

* One VM with an http load balancer that distributes traffic between the next two machines (you can choose what software to use for load balancing). DON'T USE GCP Load balancers. This machine will have to have public IP.
* One LINUX VM serving a static webpage which says "This is machine ${hostname} running ${os version}
* One Windows VM serving a static webpage which says "This is machine ${hostname} running ${os version}
* The load balancer should distribute the load round-robin between the Linux and the Windows VM, so that when accesing its IP, every reload should randomly return the webpage of one or another node.
  
### General rules: 

* Manage Linux and Windows VMs with Ansible
* Use Ansible facts and templates to generate and copy the static .html files to each of the servers
* Use Ansible to configure a Reverse Proxy (Apache HTTP Server, Nginx, whatever you prefer...)

--------------------------------------

## Solution

### 0. Prepare working environment. Create working container with cloud-sdk + terraform + ansible

```
# Start container
docker run -it --rm -v ${PWD}:/work -w /work ansible-container:v1
```

### 1. Create main.tf file. And other needed .tf files.

```
# .tf script in ./main.tf
```

* main.tf include:

* 3 Compute instances.
   
  - One with internal Nginx LB which redirect to other 2 instances.
  
```
# .yaml file in ./lb.yaml
```

  - Two instances with debian and configured by j2 template. (Without Win vm's, only linux)
  
```
# .yaml file in ./debian.yaml 
# Already changed because use in Task 2
```

* Each Instances configured with Ansible provisioner


-----------------------------------------

## Task 2 (extending Task 1)

## Main goals.

* Install Fortune game on instances.
* Make cgi script which print `fortune` phrases on web-server page.

## Solution.

### 1. Rewrite .j2 templates and Playbooks for each instance.

```
# Instances configured in ./debian1.yaml ./debian2.yaml files.
```

### 2. Write and configure python cgi scrpipt.

```
# Python CGI configured in ./debian1.yaml ./debian2.yaml

# Template for .py script in ./templates/web.j2
```

### 3. (optional) Make link in Python cgi output which back to LB ip.

```
# Configured in main.tf in instance3 resource (lb), 2 lasts local-exec provisioners in 
./finalize.yaml file
```

---------------------------------------