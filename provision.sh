#!/bin/bash
MINECRAFT_HOME=/opt/minecraft
DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar"
apt-get update
apt-get upgrade
apt-get install -y openjdk-8-jre
adduser --system --home $MINECRAFT_HOME minecraft
addgroup --system minecraft
adduser minecraft minecraft
curl -s $DOWNLOAD_URL --output $MINECRAFT_HOME/server.jar > /dev/null
cd $MINECRAFT_HOME
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i -e 's/false/true/g' eula.txt
chown -R minecraft:minecraft $MINECRAFT_HOME
cp /vagrant/minecraft-server.service /etc/systemd/system/
chown root:root /etc/systemd/system/minecraft-server.service
chmod 755 /etc/systemd/system/minecraft-server.service
systemctl daemon-reload
systemctl enable minecraft-server.service
systemctl start minecraft-server
systemctl status minecraft-server
