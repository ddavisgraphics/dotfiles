#!/bin/bash
# if ! which mise >/dev/null; then
#   echo "mise is not installed. Please install it first."
#   brew install mise
#   echo "mise seed"
# fi

# # RUBY =======================================================================
# echo "\n Installing Plugins \n"

# mise plugin install ruby
# mise plugin install rust https://github.com/code-lever/asdf-rust.git

# echo "\n Done Installing Plugins \n"

# # setup versions
# mise cache clean
# mise ls-remote ruby

# # Install Languages =======================================================================
# echo "Installing Ruby..."
# mise use -g ruby@latest

# echo "Installing Node.js..."
# mise use -g node@lts

# echo "Installing Rust..."
# mise use -g rust@latest

# echo "Installing Python..."
# mise use -g python@latest

# echo "Installing Yarn..."
# mise use -g yarn@latest


echo "Installing Common Gems"
# add gems to use
gem install rake
gem install rails
gem install solargraph
gem install tmuxinator
gem install benchmark-ips
gem install rubocop


