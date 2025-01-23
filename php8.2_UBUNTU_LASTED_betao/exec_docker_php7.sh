#/bin/bash

echo "parando o apache e mysql"

### parar o apache e mysql
sudo service apache2 stop
sudo service mysql stop

echo "apache e mysql parado"

##fazendo o build do docker
echo "entrando no diretorio do docker"
cd /home/sistemas/sistemas/dev_ambientes/php7_server
echo "executando o build"
sudo docker build -t server_php7:v1 .

echo "build feito"

echo "docker-compose up"
sudo docker-compose up -d

echo "rodando o docker-compose ps"
docker-compose ps

echo "rodando o docker ps"
docker ps

echo "feito"

