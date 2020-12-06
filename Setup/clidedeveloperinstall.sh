#/bin/bash

spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
# define function to check if program is installed
# courtesy of https://gist.github.com/JamieMason/4761049
function program_is_installed {
    # set to 1 initially
    local return_=1
    # set to 0 if not found
    type $1 >/dev/null 2>&1 || { local return_=0; }
    # return value
    echo $return_
}

# print a pretty header
echo
echo " +---------------------------------------------------+"
echo " |                CHANGE HOSTS NAME                  |"
echo " +---------------------------------------------------+"
echo

sudo gedit /etc/hostname /etc/hosts

apt install software-properties-common apt-transport-https wget
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
add-apt-repository ppa:linuxuprising/java
echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/linuxuprising-java.list
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
add-apt-repository ppa:jonathonf/python-3.6
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

apt-get update
cat << "EOF"
                   :.                                                                     
                             /:                                                                     
                            -s-                                                                     
                          `:s+                                                                      
                        `:os:                                                                       
                      ./so:`   .--.`                                                                
                   `-oso:` `-/+:.`                                                                  
                  -oss:` `/oo:`                                                                     
                 +ss+`  -ss/`                                                                       
                .ss+    sss`                        ...                                             
                 /s+    oss+`                       oss.                                            
                  :o-   .osso.                      oss.     ````                      ````         
                   `/-   `/sso                      oss.  :++++oo+:` `+o+`    -oo- `/++++oo+- .-`   
                     ..    +s/                      oss.  --..`.:ss+  /ss/    +ss` `:...../ss:      
           ```..`         ./-        .--/:.         oss.     ````oss  `oss.  `ss/      ```.ss+      
        ./+o/-.````  `````..``...-.     `/s:        oss.  ./+++++sss   -sso  /ss`  `-++++++ss+      
        .-://///////////:::::---.`       /s/        oss. :ss:``  oss    /ss--ss:   +ss.`  `ss+      
             `.                        `/o/`        oss. +ss-```.oss    `ssoos+   `sso````:ss+      
            .os:---...----:://+:`    `:/:`          oss` .osso+o+/ss     :ssso`    :oso++o/+s/      
             .-:://+++++++//:--.`   `.`            -ss+    `...`  ``      ````      `....` ```      
              `-`            `                   ./ss/`                                             
              /so+////////++oo/.                 `:-`                                               
      ``...`   `-::///++///:-.`         `                                                           
    :+s+`                            `.-:`                                                          
    :/+oso++///:::::::::::::///////:::.` .-.                                                        
         ``......------......`````..-::::.                                                          
            `..---:::::::::::::::--.`                                                               
EOF
apt-get install oracle-java13-set-default
spinner $!
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
cat << "EOF"
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMNNNNNNMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMmysooosssssssydMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMmoo-./ssssssssssyNMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMdoo:-+sssssssssyyNMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMmyyyyyyyyssssyyyyNMMMMMMMMMMMMMMMM
MMMMMMMMMMmhyyyyyyyyyyyhysssyyyyyN+///+yNMMMMMMMMM
MMMMMMMMNsoooossssssssssssyyyyyyyN-.....:NMMMMMMMM
MMMMMMMMyoooosssssssssssyyyyyyyyyN.......oMMMMMMMM
MMMMMMMNooosssssssssssyyyyyyyyyhd/.......-MMMMMMMM
MMMMMMMNossssssssyhysssssssssss/......----dMMMMMMM
MMMMMMMMssssssssds.................-------NMMMMMMM
MMMMMMMMhssssssyh................--------sMMMMMMMM
MMMMMMMMMyssssshy.............----------+MMMMMMMMM
MMMMMMMMMMmddddmy........ooooooooooooosdMMMMMMMMMM
MMMMMMMMMMMMMMMMy.......---------dMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMy....-------```--dMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMN/----------.`.-+NMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMds+:------/+sdMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMNNNMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                                    
EOF
sudo apt-get install python3.6
spinner $!
sudo apt-get install netbeans
cat << "EOF"
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyyso+yhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhysso+//////yhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhysoo+////////////yhhhhhhhhhh
hhhhhhhhhhhhhhhyyso++//////////////////yhhhhhhhhhh
hhhhhhhhhhhso+/////////////////////////yhhhhhhhhhh
hhhhhhhhhhy////////////////////////++oshhhhhhhhhhh
hhhhhhhhhhy//////////////////+oosyhhhhhhhhhhhhhhhh
hhhhhhhhhhy////////////////+osyhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhy/////////////////////++osyyhhhhhhhhhhhh
hhhhhhhhhhy+///////////////////////////yhhhhhhhhhh
hhhhhhhhhhhhhysoo+/////////////////////yhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhyso+////////////////yhhhhhhhhhh
hhhhhhhhhhhhhhhhysso+++++++++//////////yhhhhhhhhhh
hhhhhhhhhhhso++//////////++++++++++////yhhhhhhhhhh
hhhhhhhhhhy/////////////////////++++osshhhhhhhhhhh
hhhhhhhhhhy//////////////////+ossyhhhhhhhhhhhhhhhh
hhhhhhhhhhy////////////+osyyhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhy//////+osyhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhoosyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
dhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdd                                    
EOF
sudo apt-get install sublime-text
spinner $!
sudo snap install pycharm-community --classic
spinner $!
cat << "EOF"
                              .                   
                            -osso/-.              
                          -oyyyyyyyso             
           .--`         -oyyyyyyyyyys             
          :syys/.     -oyyyyyssyyyyys             
          :yy+syso-`.+yyyyyo:`oyyyyys             
          :yy`.+yyysyyyys+-`  oyyyyys             
          :yy`  :yyyyyyo-     oyyyyys             
          :yy`.+syysyyyys+.`  oyyyyys             
          :yy+syso:`.+yyyyyo:`oyyyyys             
          :syys/.     -oyyyyyssyyyyys             
           .--`         -oyyyyyyyyyys             
                          -oyyyyyyyso             
                            -osso/-.              
                              .`                                                     
EOF
sudo apt install code
spinner $!
cat << "EOF"
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMho/-..........................-/ohMMMMMMMM
MMMMMm+`                                  `+mMMMMM
MMMMy`     ```````````````````````````      `yMMMM
MMMs` ``````````````````::``````````````````  sMMM
MMN.````````````````````yh````````````````````.NMM
MMm`````````````````````yh`````````````````````mMM
MMd`````````````````:+oshhso+:`````````````````mMM
MMd``````````````-ohs+:-yh-:+sho-``````````````mMM
MMd`````````````+ho-..``yh``..-oh+`````````````mMM
MMd````````````+h+.`````:/`````.+h+````````````mMM
MMd```````----:hy:---````````---:yh:----```````mMM
MMd``````.ooooshyoooo.``````.ooooyhsoooo.``````mMM
MMd```````.....sh-...````````...-hy.....```````mMM
MMd````````````-yy-`````ss`````-yy-````````````mMM
MMd`````````````-oho-```yh```:oho-`````````````mMM
MMd``````````````.-+shyohhoyhs+-.``````````````mMM
MMd````````````````...-:hh:-...````````````````mMM
MMm`````````````````````yh`````````````````````mMM
MMM/````````````````````ss````````````````````/MMM
MMMN:```````````````````..```````````````````:NMMM
MMMMNs.`````````````````..`````````````````.sNMMMM
MMMMMMNy+-..............................-+yNMMMMMM
MMMMMMMMMMNddhhhhhhhhhhhhhhhhhhhhhhhhddNMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                                  
EOF
apt install clamav clamav-daemon
spinner $!
apt install clamtk
spinner $!
apt install dconf-tools
apt install gnome-tweaks
apt install arc-theme
apt install adwaita-icon-theme-full
apt install arc-theme
apt install numix-gtk-theme numix-icon-theme
apt install gnome-shell-extensions
curl -L git.io/firefoxdev | sh
curl -L git.io/firefoxnightly | sh
mkdir /home/.themes
gsettings set org.gnome.desktop.background picture-uri "file:///home/ewhtp4/Setup/default_wallpaper.jpg" 
tar -xf themes.tar.xz --directory /home/ewhtp4/.themes
gsettings set org.gnome.desktop.interface gtk-theme "Savile-Row" 
gsettings set org.gnome.desktop.interface icon-theme 'numix-icon-theme'  
gsettings set org.gnome.desktop.wm.preferences theme "Savile-Row" 
sudo apt-get install apache2 -y
apt install gnome-panel -y
apt install net-tools -y
sudo apt-get install -y bind9 -y
systemctl enable bind9
systemctl restart bind9
sudo apt install php libapache2-mod-php -y
sudo apt install php-fpm -y
sudo apt install php-mysql php-gd -y

sudo apt-get install mysql-server -y
sudo mysql_secure_installation utility -y
sudo ufw enable
sudo ufw allow mysql
systemctl start mysql
systemctl enable mysql

sudo apt install php7.2 php7.2-cli php7.2-mysql php7.2-json php7.2-opcache php7.2-mbstring php7.2-intl php7.2-xml php7.2-gd  php7.2-zip php7.2-curl php7.2-xmlrpc php7.2-xmlrpc -y
cp backup.sh /
crontab -l > mycron
#echo new cron into cron file
echo "59 23 * * 0-6 /./backup.sh" >> mycron
#install new cron file
crontab mycron

