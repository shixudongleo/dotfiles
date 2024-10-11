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



brew install zip unzip 
brew install docker docker-compose docker-completion
brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper  