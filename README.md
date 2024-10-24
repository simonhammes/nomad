# Nomad

## Prerequisites
- Vagrant

## General Instructions
```bash
vagrant up

vagrant ssh

# Inside VM
nomad status
```

### nginx.nomad.hcl
```bash
# Inside VM
nomad run /vagrant/jobs/nginx.nomad.hcl
nomad status

# Inside VM
curl localhost:80 -I

# Host
curl localhost:8080 -I
```
