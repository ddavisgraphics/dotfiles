#!/bin/bash
if ! which asdf >/dev/null; then
  echo "asdf is not installed. Please install it first."
  brew install asdf
  echo "asdf installed"
fi

# RUBY =======================================================================
# install ruby
asdf plugin-add ruby

# setup versions
asdf install ruby 3.3.0
asdf install ruby 3.2.3
asdf install ruby 3.1.4
asdf install ruby 3.0.6

asdf local ruby 3.3.0

# add gems to global
gem install rake
gem install rails
gem install tmuxinator
gem install benchmark-ips

# NODE =======================================================================
asdf plugin-add nodejs
asdf install nodejs lts
asdf global nodejs lts

asdf plugin-add yarn
asdf install yarn latest
# yarn set version 2.4.1

# RUST =======================================================================
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf install rust stable

# PYTHON ======================================================================
asdf plugin-add python
asdf install python 3.10.0
asdf global python 3.10.0 2.7.18