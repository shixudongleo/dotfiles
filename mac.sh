#!/bin/sh

# Welcome to shixudongleo laptop script!
# Be prepared to turn your laptop into 
# an awesome development machine.
# reference: thoughtbot laptop script.


fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}


brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}



if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew ..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update
brew install brew-cask

# basic tools
fancy_echo "Installing basic tools ..."
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'vim'
brew_install_or_upgrade 'openssl'
brew unlink openssl && brew link openssl --force
brew_install_or_upgrade 'wget'
brew_install_or_upgrade 'cmake'
brew_install_or_upgrade 'python'
brew_install_or_upgrade 'numpy'
brew_install_or_upgrade 'opencv'
# brew_install_or_upgrade 'pygame'
brew cask install java
brew cask install xquartz

# global python packages
pip install --upgrade pip
pip install --upgrade ipython
pip install --upgrade ipdb
pip install --upgrade virtualenv
pip install --upgrade virtualenvwrapper
pip install --upgrade requests

pip install --upgrade numpy
pip install --upgrade scipy
pip install --upgrade scikit-learn
pip install --upgrade matplotlib

# setup python virtualenvs
fancy_echo "Setting up virtualenvs ..."
if [ ! -d "$HOME/virtualenvs/" ]; then
    mkdir "$HOME/virtualenvs"
fi

# make computer vision virtualenv
if [ ! -d "$HOME/virtualenvs/cv_env" ]; then
    fancy_echo "Make computer vision virtualenv"
    virtualenv --system-site-packages "$HOME/virtualenvs/cv_env"
    source "$HOME/virtualenvs/cv_env/bin/activate"
    pip install --upgrade Pillow
    pip install --upgrade scikit-image
    deactivate
else
    fancy_echo "Already created virtualenv %s. Skipping ..." "$HOME/virtualenvs/cv_env"
fi

# make machine learing virtualenv
if [ ! -d "$HOME/virtualenvs/ml_env" ]; then
    fancy_echo "Make machine learning virtualenv"
    virtualenv --system-site-packages "$HOME/virtualenvs/ml_env"
    source "$HOME/virtualenvs/ml_env/bin/activate"
    pip install --upgrade scikit-learn
    pip install --upgrade pandas
    deactivate
else
    fancy_echo "Already created virtualenv %s. Skipping ..." "$HOME/virtualenvs/ml_env"
fi


# make kivy virtualenv
if [ ! -d "$HOME/virtualenvs/kivy_env" ]; then
    fancy_echo "Make kivy virtualenv"
    brew cask install kivy
    ln -s /opt/homebrew-cask/Caskroom/kivy/1.9.0/Kivy.app/Contents/Resources/script /usr/local/bin/kivy
    mkdir -p "$HOME/virtualenvs/kivy_env/bin"
    ln -s /opt/homebrew-cask/Caskroom/kivy/1.9.0/Kivy.app/Contents/Resources/venv/bin/activate "$HOME/virtualenvs/kivy_env/bin/activate"
    source "$HOME/virtualenvs/kivy_env/bin/activate"
    # pip install --upgrade 
    deactivate
else
    fancy_echo "Already created virtualenv %s. Skipping ..." "$HOME/virtualenvs/kivy_env"
fi

# daily use softwares
fancy_echo "Installing dayly use softwares"
brew cask install google-chrome
brew cask install firefox
brew cask install teamviewer
brew cask install mactex
brew cask install sublime-text
brew cask install vlc
