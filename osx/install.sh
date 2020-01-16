#!/usr/bin/env bash


FILE="${HOME}/Brewfile"

/bin/cat <<EOM >$FILE
# Install all Cask Applications Globally
cask_args appdir: '/Applications'

# Brew Taps
tap 'caskroom/homebrew-cask' || true

# Brew List
brew 'ack'
brew 'amazon-ecs-cli'
brew 'ansible'
brew 'ansible-lint'
brew 'awscli'
brew 'cmake'
brew 'ctags'
brew 'coreutils'
brew 'dep'
brew 'diffutils'
brew 'direnv'
brew 'fzf'
brew 'git'
brew 'git-crypt'
brew 'git-extras'
brew 'gnu-sed', args: ["with-default-names"]
brew 'grep', args: ["with-default-names"]
brew 'go'
brew 'htop'
brew 'jq'
brew 'jsonlint'
brew 'kubectx'
brew 'kube-ps1'
brew 'kubernetes-cli'
brew 'kubernetes-helm'
brew 'kube-prompt'
brew 'neovim'
brew 'node'
brew 'packer'
brew 'pre-commit'
brew 'shellcheck'
brew 'terraform'
brew 'terraform-docs'
brew 'tflint'
brew 'tfschema'
brew 'tmux'
brew 'watch'
brew 'wget'
brew 'whois'
brew 'zsh'

# Casks
cask 'aws-vault'
cask 'docker'
cask 'google-chrome'
cask 'inspec'
cask 'iterm2'
cask 'minikube'
cask 'slack'
cask 'textmate'
cask 'virtualbox'
cask 'vagrant'
EOM
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/usr/local/bin/brew bundle install
