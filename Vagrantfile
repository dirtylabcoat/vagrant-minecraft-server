VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE = "bento/ubuntu-20.04"
BOX_NAME = "minecraft-server"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = BOX_IMAGE
    config.vm.hostname = BOX_NAME
    config.vm.network "public_network", mac: "1ECAE1ECAE00", ip: "192.168.1.199"
    config.vm.provider :virtualbox do |vb|
        vb.name = BOX_NAME
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        #vb.customize ["modifyvm", :id, "--cpus", 2]
    end
    config.vm.provision :shell, path: "provision.sh"
end
