# basic requirements 
sudo apt-get install build-essential procps curl file git
# install homebrew for linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# install zshell 
sudo apt-get install -y zsh curl git
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# setup swap
sudo swapon --show
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo swapon --show


# setup ssh key
read -p "Enter your email for the SSH key: " SSH_EMAIL
ssh-keygen -t rsa -b 4096 -C "$SSH_EMAIL" -f ~/.ssh/id_rsa -N ""




brew install zip unzip 
brew install docker docker-compose docker-completion


sudo apt update
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper  