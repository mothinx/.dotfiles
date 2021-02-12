echo "Upgrade everything before install..."
sudo apt-get update && sudo apt upgrade -y

echo "Downloading tools..."
sudo apt-get -y install zsh git tree zip unzip \
    redshift rclone
if [ ! -e /usr/bin/keepassxc ]; then
    sudo apt-get -y install keepassxc
fi

echo "Downloading coding stuff..."
sudo apt-get -y install openjdk-8-jdk

if [ ! -d $HOME/idea ]; then
    echo "Downloading and installing IntelliJ Idea..."
    mkdir $HOME/idea
    wget -c https://download.jetbrains.com/idea/ideaIU-2020.3.2.tar.gz -O - | tar -xz -C ~/idea
    rm $HOME/Downloads/idea*
fi

echo "Downloading apps..."
sudo apt-get -y install firefox libreoffice libreoffice-l10n-fr

if [ ! -e /usr/bin/spotify ]; then
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get -y install spotify-client
fi

if [ ! -e /usr/games/steam ]; then
    sudo apt-get -y install steam
fi

if [ "$SHELL" != '/usr/bin/zsh' ]; then
    echo "Using zsh as default shell. Note: Login / Logout..."
    chsh -s $(which zsh)

    echo "Downloading Oh-My-Zsh..."
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi