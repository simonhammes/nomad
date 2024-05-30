# Nomad

## Prerequisites
- Vagrant

## General Instructions
```bash
vagrant up

vagrant ssh

nomad status
```

### nginx.nomad.hcl
```bash
nomad run /vagrant/jobs/nginx.nomad.hcl

nomad status

# VM
curl localhost:80 -I

# Host
curl localhost:8080 -I
```
