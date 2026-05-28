Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.box_architecture = "arm64"

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provision "shell", path: "script.sh"
end
