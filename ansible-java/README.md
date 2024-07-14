# Ansible to install Java on Cloud9 instances via SSM

## Prerequisites

Locally, Ansible and the session-manager plugin need to be installed.
So do the Galaxy roles.

```shell
pip install -U ansible boto3
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
ansible-galaxy role install geerlingguy.java geerlingguy.ansible \
    gantsign.maven andrewrothstein.terraform andrewrothstein.kubectl 
```

## Running

Test the dynamic inventory with

``` shell
ansible-inventory -i inventory-aws_ec2.yaml --graph
```

Run with

```shell
ansible-playbook -i inventory-aws_ec2.yaml java.yaml
ansible-playbook -i inventory-aws_ec2.yaml terraform.yaml
ansible-playbook -i inventory-aws_ec2.yaml put-files.yaml
ansible-playbook -i inventory-aws_ec2.yaml docker.yaml
ansible-playbook -i inventory-aws_ec2.yaml kube.yaml
ansible-playbook -i inventory-aws_ec2.yaml git.yaml
```
