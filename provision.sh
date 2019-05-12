#!/bin/bash
MINECRAFT_USER=minecraft
MINECRAFT_GROUP=minecraft
MINECRAFT_HOME=/opt/minecraft
# 1.13.2 = DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar"
DOWNLOAD_URL="https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar"
apt-get update
#apt-get upgrade
apt-get install -y openjdk-8-jre screen
adduser --quiet --disabled-password --shell /bin/bash --home $MINECRAFT_HOME --gecos "Minecraft user" $MINECRAFT_USER
echo "$MINECRAFT_USER:minecraft" | chpasswd
adduser $MINECRAFT_USER $MINECRAFT_GROUP
curl -s $DOWNLOAD_URL --output $MINECRAFT_HOME/server.jar > /dev/null
cd $MINECRAFT_HOME
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i -e 's/false/true/g' eula.txt
cp /vagrant/startserver.sh $MINECRAFT_HOME/
chmod +x $MINECRAFT_HOME/startserver.sh
cp /vagrant/startserverinscreen.sh $MINECRAFT_HOME/
chmod +x $MINECRAFT_HOME/startserverinscreen.sh
chown -R $MINECRAFT_USER:$MINECRAFT_GROUP $MINECRAFT_HOME
cp /vagrant/minecraft-server.service /etc/systemd/system/
chown root:root /etc/systemd/system/minecraft-server.service
chmod 755 /etc/systemd/system/minecraft-server.service
systemctl daemon-reload
systemctl enable minecraft-server.service
systemctl start minecraft-server
systemctl status minecraft-server
