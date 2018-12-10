# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

@script = <<SCRIPT
# Install dependencies
 apt-get update \
 && apt-get install -y git zlib1g-dev apache2 git curl php7.0 php7.0-bcmath php7.0-bz2 php7.0-cli php7.0-curl php7.0-intl php7.0-json php7.0-mbstring php7.0-opcache php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-xsl php7.0-zip libapache2-mod-php7.0 \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

 curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
 chmod +x /usr/local/bin/docker-compose

 #install docker
 apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update && apt-get install -y docker-ce

usermod -aG docker vagrant

# Reset home directory of vagrant user
if ! grep -q "cd /var/www" /home/vagrant/.profile; then
    echo "cd /var/www" >> /home/vagrant/.profile
fi

echo "127.0.0.1 selenium" >> /etc/hosts

cd /var/www && composer install && docker-compose pull && docker-compose build

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 4444, host: 4444
  config.vm.network "forwarded_port", guest: 8111, host: 8111
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder '.', '/var/www'
  config.vm.provision 'shell', inline: @script

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--name", "Automation practice - Ubuntu 16.04"]
  end
end
