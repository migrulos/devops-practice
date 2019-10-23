Docker-install
=========

This role was made just to practice at Ansible.
To install docker in Linux, you can use the role geerlingguy.docker.

Requirements
------------

CentOS7

Role Variables
--------------

"docker_compose_url" - last release of docker-compose

Example Playbook
----------------

```yaml
- name: Install docker
  hosts: all
  gather_facts: yes
  become: yes

  roles:
    - docker-install
```

License
-------

MIT

Author Information
------------------

By migrulos, 2019. Feedback and bug reports welcome.  
(https://github.com/migrulos)
