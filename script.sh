#!/bin/bash

apt-get update
apt-get install -y curl git make build-essential python3 postgresql postgresql-contrib
apt-get purge -y nodejs npm || true

systemctl start postgresql
systemctl enable postgresql

# база данных
sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';" || true
sudo -u postgres psql -c "ALTER USER vagrant WITH PASSWORD 'vagrant';"
sudo -u postgres createdb -O vagrant vagrant || true

# nodejs
su - vagrant -c 'curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash'
su - vagrant -c 'export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; nvm install 20; nvm alias default 20'

# копируем проект
rm -rf /home/vagrant/js-fastify-blog
cp -r /vagrant/js-fastify-blog /home/vagrant/js-fastify-blog
chown -R vagrant:vagrant /home/vagrant/js-fastify-blog

# останавливаем старый запуск
pkill -f "fastify start" || true
pkill -f "npm run start" || true

# запускаем проект
su - vagrant -c 'cd /home/vagrant/js-fastify-blog && export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; nvm use default; make prepare-env'
su - vagrant -c 'cd /home/vagrant/js-fastify-blog && export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; nvm use default; make install'
su - vagrant -c 'cd /home/vagrant/js-fastify-blog && export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; nvm use default; make build'
su - vagrant -c 'cd /home/vagrant/js-fastify-blog && export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"; nvm use default; nohup make start > app.log 2>&1 &'
