Aidbox
=========

Deploy Aidbox (https://docs.aidbox.app/installation/setup-aidbox.dev) on CentOS7

Requirements
------------

CentOS7  
Installed docker and docker-compose (to install docker in Linux, you can use the role geerlingguy.docker)

Role Variables
--------------

"license_id" and "license_key" - get license id and key here: https://license-ui.aidbox.app

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

MIT

Author Information
------------------

By migrulos, 2019. Feedback and bug reports welcome.  
(https://github.com/migrulos)
