sudo apt update && apt upgrade -y
sudo curl -fsSL https://get.docker.com | sh
sudo apt install docker-compose -y
sudo groupadd docker 
sudo usermod -aG docker $USER
sudo systemctl restart docker
