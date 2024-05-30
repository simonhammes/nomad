Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # Expose Nomad Web UI
  config.vm.network "forwarded_port", guest: 4646, host: 4646, host_ip: "127.0.0.1"

  # Expose application ports
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end

  config.vm.provision "deps", type: "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      jq \
      software-properties-common \
      zip

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
    echo "deb [signed-by=/usr/share/keyrings/docker.gpg arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

    apt-get update
    apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      nomad

    usermod -aG docker vagrant
  SHELL

  config.vm.provision "app:setup", type: "shell", run: "always", inline: <<-SHELL
    # /vagrant is automatically mounted by Vagrant :)
    cp /vagrant/nomad.hcl /etc/nomad.d/

    # TODO: Is this necessary?
    sudo systemctl enable nomad
    # TODO: Is this necessary?
    sudo systemctl start nomad
  SHELL
end
