# vagrant-minecraft-server
Set up a basic Minecraft server using Vagrant.

Run
```
vagrant up
```
in the root-directory and wait for it to finish. That's it.

The server is based on Ubuntu 16.04LTS and runs OpenJDK 8. It has a static IP of 192.168.1.199 and a MAC-address of 1ECAE1ECAE00 but these may be changed if needed to suit your own network.

The Minecraft Server application is installed as a service and starts automatically when the VM boots up. The service is called "minecraft-server" and can be controlled with
```
sudo service minecraft-server {stop|start|status}
```

Have fun!
