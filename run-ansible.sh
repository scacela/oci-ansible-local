#!/bin/bash

# install Ansible, necessary packages
sudo yum makecache
sudo yum install -y ansible python-netaddr

# execute site.yml in the playbook folder
ansible-playbook /home/opc/playbooks/site.yml
