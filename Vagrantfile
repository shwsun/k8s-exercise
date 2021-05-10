Vagrant.configure("2") do |config|
    # installed in /opt/vagrant/embedded .... gemrc 
    # https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box
    # vagrant box add centos/7 CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box
    # config.vbguest.auto_update = false
    # test linux 
    # 연습으로 깡통 리눅스만 올려 봅니다. 
    # vagrant up test 명령이 실행 완료되면, 리눅스 가상머신이 생성됩니다.
    # vagrant ssh test 로 리눅스 운영체제에 콘솔 연결할 수 있습니다. 
    config.vm.define "test" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "test"

        vname.trigger.before :halt do |trigger|
            trigger.warn = "Dumping database to /vagrant/outfile"
            trigger.run_remote = {inline: "echo AAAA"}
        end

        vname.vm.provider "virtualbox" do |vb|
            vb.name = "test"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 1000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.20"
    end

    # Docker VM
    config.vm.define "dock" do |machine|
        #config.vbguest.auto_update = false 
        machine.vm.box = "centos/7"
        machine.vm.hostname = "dock"
        machine.vm.provider "virtualbox" do |vb|
            vb.name = "dock"
            vb.customize ["modifyvm", :id, "--audio", "none"]
            vb.memory = 3000
            vb.cpus = 2
        end
        machine.vm.network "private_network", ip: "192.168.56.10"
        machine.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
    end

    # Git Lab VM  
    # git server 를 실행합니다. 
    # !!! 주의 : 파일 공유 설정 전에는 vm 파괴시 소스가 사라집니다. 
    # http://192.168.56.22:9001
    config.vm.define "gitlab" do |vname|
        #config.vbguest.auto_update = false
        vname.vm.box = "centos/7"
        vname.vm.hostname = "gitlab"
        #vname.vm.synced_folder "./pv/nexus", "/home/vagrant/nexus", owner: "vagrant", group: "vagrant"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "gitlab"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 2000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.22"
        vname.vm.provision "file", source: "./rpm/gitlab-ce-13.8.1-ce.0.el7.x86_64.rpm",  destination: "/home/vagrant/" , run: "once"
        vname.vm.provision "shell", path: "./shells/boot_gitlab.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_gitlab.sh", run: "always"
    end

    # Jupyter Notebook
    # http://192.168.56.23:8888 
    config.vm.define "jup" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "jup"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "jup"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 1000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.23"
        vname.vm.network "forwarded_port", guest: 8888, host: 8888
        # provisioning

        vname.vm.provision "shell", path: "./shells/boot_jupyter.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_jupyter.sh", run: "always"
    end

    # superset 
    # https://superset.incubator.apache.org/
    # http://192.168.56.24:8088 
    config.vm.define "superset" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "superset"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "superset"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 1000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.24"
        #vname.vm.network "forwarded_port", guest: 8888, host: 8888
        # provisioning

        #vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_superset.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_superset.sh", run: "always"
    end

    # mysql 
    #
    # http://192.168.56.24:8088 
    config.vm.define "mysql" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "mysql"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "mysql"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 1000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.25"
        #vname.vm.network "forwarded_port", guest: 8888, host: 8888
        # provisioning

        vname.vm.provision "shell", path: "./shells/boot_mysql.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_mysql.sh", run: "always"
    end



    ################ 개발 중.... ################
    # # Nexus - vm version   
    # config.vm.define "nexusvm" do |vname|
    #     #config.vbguest.auto_update = false
    #     vname.vm.box = "centos/7"
    #     vname.vm.hostname = "nexusvm"
    #     #vname.vm.synced_folder "./pv/nexus", "/home/vagrant/nexus", owner: "vagrant", group: "vagrant"
    #     vname.vm.provider "virtualbox" do |vb|
    #         vb.name = "nexusvm"
    #         vb.customize ['modifyvm', :id, '--audio', 'none']
    #         vb.memory = 3000
    #         vb.cpus = 3
    #     end
    #     vname.vm.network "private_network", ip: "192.168.56.21"
    #     vname.vm.provision "file", source: "./RPM_DIR/nexus-3.29.2-02-unix.tar.gz",  destination: "/home/vagrant/" , run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_nexus_vm.sh", run: "once"
    #     #vname.vm.provision "file", source: "./RPM_DIR/",  destination: "./" , run: "once"
    # end   

    # ################ K8s Cluster + 대시보드 (미니큐브 아님) ################
    # # config.vbguest.auto_update = false
    # # K8s Master 를 설치하고 Dashboard 까지 설치. 
    # # Dashboard URL : http://192.168.56.10:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # # Dashboard URL : http://172.17.149.65:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # # Dashboard URL : External Port mapping 
    #   http://10.250.106.233:18001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # config.vm.define "k8s" do |vname|
    #     vname.vm.box = "centos/7"
    #     vname.vm.hostname = "k8s"
    #     #vname.vm.synced_folder "./notebook", "/home/vagrant/notebook", owner: "vagrant", group: "vagrant"
    #     vname.vm.provider "virtualbox" do |vb|
    #         vb.name = "k8s"
    #         vb.customize ['modifyvm', :id, '--audio', 'none']
    #         vb.memory = 8000
    #         vb.cpus = 4
    #     end
    #     vname.vm.network "private_network", ip: "192.168.56.10"
    #     vname.vm.network "forwarded_port", guest: 8001, host: 18001
    #     vname.vm.provision "file", source: "./shells/yml/",  destination: "~/" , run: "once"
    #     # provisioning
    #     vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_k8s.sh", run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_master.sh", run: "once"

    #     vname.vm.provision "shell", path: "./shells/start_master.sh", run: "always"
    #     vname.vm.provision "shell", path: "./shells/install_k8s_dashboard.sh", run: "always"
    # end

    # Manage VM Disk size
    # VBoxManage clonehd "box-disk1.vmdk" "cloned.vdi" --format vdi
    # VBoxManage modifyhd "cloned.vdi" --resize 51200
    # VBox add new Hard disk instead of old one 


    # K8s : local test용 작은 크기 
    # k8s halt 시 실행 중이던 모든 k8s 리소스가 초기화 됩니다.  
    # # Dashboard URL : http://192.168.56.10:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # # Dashboard URL : http://10.250.106.233:18001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # kubectl get secrets , kubectl describe secrets default-token-lzhds
    config.vm.define "k8s" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "k8s"
        #vname.vm.synced_folder "./notebook", "/home/vagrant/notebook", owner: "vagrant", group: "vagrant"
        vname.trigger.before :halt do |trigger|
            trigger.warn = "destroy k8s created resources."
            trigger.run_remote = {inline: "sudo chmod 755 cleanup_k8s.sh; sudo ./cleanup_k8s.sh"}
        end
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "k8s"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 3000
            vb.cpus = 3
        end
        # boot_master 등 내부 쉘에 ip 하드 코딩 된 상태라 10 사용해야...
        # 향후 머신 ip 추출해서 사용하게 쉘 변경해야 한다. 
        # CIDR 할당 시, 10.244.0.0/16 했으나, 클러스터 여러개 띄우면 나머지는 다른 대역 지정해야...
        # 예를 들어 베어메탈과 VM 2개 K8s 띄울 경우, 같은 CIDR 사용 못 하므로 하나는 172 대역 등으로 변경해야.
        vname.vm.network "private_network", ip: "192.168.56.10"
        vname.vm.network "forwarded_port", guest: 8001, host: 18001
        vname.vm.provision "file", source: "./shells/yml/",  destination: "~/" , run: "once"
        vname.vm.provision "file", source: "./shells/cleanup_k8s.sh",  destination: "~/cleanup_k8s.sh" , run: "once"
        # provisioning
        vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_k8s.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_master.sh", run: "once"

        vname.vm.provision "shell", path: "./shells/start_master.sh", args: ["192.168.56.10", "vagrant", "k8s"], run: "always"
        vname.vm.provision "shell", path: "./shells/install_k8s_dashboard.sh", args: ["vagrant"], run: "always"

        # # run some script before the guest is halted
        # vname.trigger.before :halt do |trigger|
        #     trigger.info "Dumping the database before destroying the VM..."
        #     trigger.run_remote  "bash /vagrant/cleanup_k8s.sh"
        # end
        # k8s 전체 정지 어려워서 시스템 강제 정지 
        # sudo systemctl halt 
    end

    # K8s2 : for Triton test
    # k8s halt 시 실행 중이던 모든 k8s 리소스가 초기화 됩니다.  
    # # Dashboard URL : http://192.168.56.15:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/  
    # kubectl get secrets , kubectl describe secrets default-token-lzhds
    config.vm.define "k8s2" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "k8s2"
        #vname.vm.synced_folder "./notebook", "/home/vagrant/notebook", owner: "vagrant", group: "vagrant"
        vname.trigger.before :halt do |trigger|
            trigger.warn = "destroy k8s2 created resources."
            trigger.run_remote = {inline: "sudo chmod 755 cleanup_k8s.sh; sudo ./cleanup_k8s.sh"}
        end
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "k8s2"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 4000
            vb.cpus = 4
        end
        # boot_master 등 내부 쉘에 ip 하드 코딩 된 상태라 10 사용해야...
        # 향후 머신 ip 추출해서 사용하게 쉘 변경해야 한다. 
        # CIDR 할당 시, 10.244.0.0/16 했으나, 클러스터 여러개 띄우면 나머지는 다른 대역 지정해야...
        # 예를 들어 베어메탈과 VM 2개 K8s 띄울 경우, 같은 CIDR 사용 못 하므로 하나는 172 대역 등으로 변경해야.
        vname.vm.network "private_network", ip: "192.168.56.15"
        #vname.vm.network "forwarded_port", guest: 8001, host: 18001
        vname.vm.provision "file", source: "./shells/yml/",  destination: "~/" , run: "once"
        vname.vm.provision "file", source: "./shells/cleanup_k8s.sh",  destination: "~/cleanup_k8s.sh" , run: "once"
        # provisioning
        vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_k8s.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_master.sh", run: "once"

        vname.vm.provision "shell", path: "./shells/start_master.sh", args: ["192.168.56.15", "vagrant", "k8s2"], run: "always"
        vname.vm.provision "shell", path: "./shells/install_k8s_dashboard.sh", args: ["vagrant"], run: "always"

        # # run some script before the guest is halted
        # vname.trigger.before :halt do |trigger|
        #     trigger.info "Dumping the database before destroying the VM..."
        #     trigger.run_remote  "bash /vagrant/cleanup_k8s.sh"
        # end
        # k8s 전체 정지 어려워서 시스템 강제 정지 
        # sudo systemctl halt 
    end

    # Node    
    config.vm.define "n01" do |vname|
        #config.vbguest.auto_update = true
        vname.vm.box = "centos/7"
        vname.vm.hostname = "n01"
        #vname.vm.synced_folder "./notebook", "/home/vagrant/notebook", owner: "vagrant", group: "vagrant"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "n01"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 1000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.12"
        vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/boot_k8s.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_node.sh", args: ["192.168.56.15:6443", "vagrant"], run: "always"
    end

    # # Nexus - docker version   
    # config.vm.define "nexus" do |vname|
    #     #config.vbguest.auto_update = false
    #     vname.vm.box = "centos/7"
    #     vname.vm.hostname = "nexus"
    #     #vname.vm.synced_folder "./pv/nexus", "/home/vagrant/nexus", owner: "vagrant", group: "vagrant"
    #     vname.vm.provider "virtualbox" do |vb|
    #         vb.name = "nexus"
    #         vb.customize ['modifyvm', :id, '--audio', 'none']
    #         vb.memory = 3000
    #         vb.cpus = 3
    #     end
    #     vname.vm.network "private_network", ip: "192.168.56.21"
    #     vname.vm.provision "file", source: "./RPM_DIR/nexus-3.29.2-02-unix.tar.gz",  destination: "/home/vagrant/" , run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_docker.sh", run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_nexus.sh", run: "once"
    #     #vname.vm.provision "file", source: "./RPM_DIR/",  destination: "./" , run: "once"
    # end

    # # Nexus - vm version   
    # config.vm.define "nexusvm" do |vname|
    #     #config.vbguest.auto_update = false
    #     vname.vm.box = "centos/7"
    #     vname.vm.hostname = "nexusvm"
    #     #vname.vm.synced_folder "./pv/nexus", "/home/vagrant/nexus", owner: "vagrant", group: "vagrant"
    #     vname.vm.provider "virtualbox" do |vb|
    #         vb.name = "nexusvm"
    #         vb.customize ['modifyvm', :id, '--audio', 'none']
    #         vb.memory = 3000
    #         vb.cpus = 3
    #     end
    #     vname.vm.network "private_network", ip: "192.168.56.21"
    #     vname.vm.provision "file", source: "./RPM_DIR/nexus-3.29.2-02-unix.tar.gz",  destination: "/home/vagrant/" , run: "once"
    #     vname.vm.provision "shell", path: "./shells/boot_nexus_vm.sh", run: "once"
    #     #vname.vm.provision "file", source: "./RPM_DIR/",  destination: "./" , run: "once"
    # end

    # Elastic Search + (Kibana)
    # http://192.168.56.15:9200 
    # http://192.168.56.15:5601 
    config.vm.define "elk" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "elk"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "elk"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 2000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.15"
        #vname.vm.network "forwarded_port", guest: 8888, host: 8888
        # provisioning
        vname.vm.provision "file", source: "./rpm/elasticsearch-oss-7.9.3-x86_64.rpm",  destination: "./" , run: "once"
        vname.vm.provision "file", source: "./rpm/kibana-7.10.2-x86_64.rpm",  destination: "./" , run: "once"
        vname.vm.provision "shell", path: "./shells/boot_elk.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_elk.sh", run: "always"
    end

    # NiFi
    # 설치파일 다운로드 중... 
    # http://192.168.56.16:8080/nifi
    config.vm.define "nifi" do |vname|
        vname.vm.box = "centos/7"
        vname.vm.hostname = "nifi"
        vname.vm.provider "virtualbox" do |vb|
            vb.name = "nifi"
            vb.customize ['modifyvm', :id, '--audio', 'none']
            vb.memory = 2000
            vb.cpus = 2
        end
        vname.vm.network "private_network", ip: "192.168.56.16"
        #vname.vm.network "forwarded_port", guest: 8888, host: 8888
        # provisioning
        vname.vm.provision "shell", path: "./shells/boot_nifi.sh", run: "once"
        vname.vm.provision "shell", path: "./shells/start_nifi.sh", run: "always"
    end

end
