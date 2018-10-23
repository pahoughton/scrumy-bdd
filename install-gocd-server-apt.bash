sudo echo "deb https://download.gocd.io /" > /etc/apt/sources.list.d/gocd.list
curl https://download.gocd.io/GOCD-GPG-KEY.asc | sudo apt-key add -
sudo apt update
sudo apt install go-server
