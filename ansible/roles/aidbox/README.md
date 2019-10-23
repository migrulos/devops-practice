Aidbox
=========

Deploy Aidbox (https://docs.aidbox.app/installation/setup-aidbox.dev) on CentOS7


Foreword (disclaimer)
---------------------

This role was made just to practice at Ansible, and most of it is just a docker/docker-compose installation.  
To install docker in Linux, you can use the role geerlingguy.docker and then just apply tasks/deploy-aidbox.yml to deploy Aidbox.

Requirements
------------

CentOS7

Role Variables
--------------

"license_id" and "license_key" - get license id and key here: https://license-ui.aidbox.app  
"docker_compose_url" - last release of docker-compose

Example Playbook
----------------

```yaml
- name: Deploy Aidbox
  hosts: all
  gather_facts: yes
  become: yes

  roles:
    - aidbox
```

License
-------

BSD

Author Information
------------------

By migrulos, 2019. Feedback and bug reports welcome.  
(https://github.com/migrulos)
