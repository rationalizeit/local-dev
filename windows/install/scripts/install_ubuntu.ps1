#--- Ubuntu ---
# TODO: Move this to choco install once --root is included in that package
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with root user, unset password

RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update -y
Ubuntu1804 run apt upgrade -y
Ubuntu1804 run apt install software-properties-common git -y
Ubuntu1804 run apt-add-repository ppa:ansible/ansible -y
Ubuntu1804 run apt update -y
Ubuntu1804 run apt-get install ansible -y
