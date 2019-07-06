#!/bin/bash
MINECRAFT_USER=minecraft
MINECRAFT_GROUP=minecraft
MINECRAFT_HOME=/opt/minecraft
## 1.13.2
#DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar"
## 1.14.1
#DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar"
## 1.14.3
DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar"
apt-get update
apt-get upgrade
apt-get install -y openjdk-8-jre
adduser --system --home $MINECRAFT_HOME $MINECRAFT_USER
addgroup --system $MINECRAFT_GROUP
adduser $MINECRAFT_USER $MINECRAFT_GROUP
curl -s $DOWNLOAD_URL --output $MINECRAFT_HOME/server.jar > /dev/null
cd $MINECRAFT_HOME
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i -e 's/false/true/g' eula.txt
chown -R $MINECRAFT_USER:$MINECRAFT_GROUP $MINECRAFT_HOME
cp /vagrant/minecraft-server.service /etc/systemd/system/
chown root:root /etc/systemd/system/minecraft-server.service
chmod 755 /etc/systemd/system/minecraft-server.service
systemctl daemon-reload
systemctl enable minecraft-server.service
systemctl start minecraft-server
systemctl status minecraft-server

