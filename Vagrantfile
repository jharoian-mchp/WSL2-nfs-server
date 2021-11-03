Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 1
    vb.memory = 256
  end

  config.vm.define "nfs-server" do |srv|
    srv.vm.hostname = "nfs-server"
    
    # Uncomment the following line for static IP address
    #srv.vm.network :public_network, ip: "192.168.1.49", hostname=true

    # Uncomment the following line for DHCP assigned IP address
    srv.vm.network :public_network, type: "dhcp"

    # Run script to complete setup inside VM
    srv.vm.provision "shell", path: "nfs-server_setup.sh", keep_color: false
  end
end
