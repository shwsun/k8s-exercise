cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
sudo yum-config-manager --save --setopt=kubernetes.sslverify=false


# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# openssl s_client -showcerts -connect packages.cloud.google.com:443
# Self-Signed Root CA 인증서 생성
# 아래 설치시 repo https 연결시 인증 에러 발생하기 때문. 
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

# 1.20.1 로 다운로드 
# k8s.gcr.io/kube-apiserver:v1.20.2
# k8s.gcr.io/kube-controller-manager:v1.20.2
# k8s.gcr.io/kube-scheduler:v1.20.2
# k8s.gcr.io/kube-proxy:v1.20.2
# k8s.gcr.io/pause:3.2
# k8s.gcr.io/etcd:3.4.13-0
# k8s.gcr.io/coredns:1.7.0 

# kubeadm 등 util 사용에 필요한 image pull
# 임시로 k8s.gcr.io 대신 shwsun docker hub 에서 설치 
sudo docker pull shwsun/kube-apiserver:v1.20.2
sudo docker pull shwsun/kube-controller-manager:v1.20.2
sudo docker pull shwsun/kube-scheduler:v1.20.2
sudo docker pull shwsun/kube-proxy:v1.20.2
sudo docker pull shwsun/pause:3.2
sudo docker pull shwsun/etcd:3.4.13-0
sudo docker pull shwsun/coredns:1.7.0 
sudo docker image tag shwsun/kube-apiserver:v1.20.2 k8s.gcr.io/kube-apiserver:v1.20.2
sudo docker image tag shwsun/kube-controller-manager:v1.20.2 k8s.gcr.io/kube-controller-manager:v1.20.2
sudo docker image tag shwsun/kube-scheduler:v1.20.2 k8s.gcr.io/kube-scheduler:v1.20.2
sudo docker image tag shwsun/kube-proxy:v1.20.2 k8s.gcr.io/kube-proxy:v1.20.2
sudo docker image tag shwsun/pause:3.2 k8s.gcr.io/pause:3.2
sudo docker image tag shwsun/etcd:3.4.13-0 k8s.gcr.io/etcd:3.4.13-0
sudo docker image tag shwsun/coredns:1.7.0  k8s.gcr.io/coredns:1.7.0 

sudo docker image rm shwsun/kube-apiserver:v1.20.2 shwsun/kube-controller-manager:v1.20.2 shwsun/kube-scheduler:v1.20.2
sudo docker image rm shwsun/kube-proxy:v1.20.2 shwsun/pause:3.2 shwsun/etcd:3.4.13-0 shwsun/coredns:1.7.0 

#스왑 오프
sudo swapoff -a

# export HOME=/home/vagrant
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

# firewall
# BareMetal K8s master
#firewall-cmd --permanent --add-port=8001/tcp
# VM K8s master
# 방화벽 포트 직접 지정해야 한다. 8001 외에 서비스 목록 확인해야...
# firewall-cmd --permanent --add-port=18001/tcp
# firewall-cmd --reload 
# firewalld 비활성화 . 개발용 임시 조치
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# kube-apiserver, kube-scheduler, etcd, kube-controller-manager
# , /usr/bin/kubelet, /usr/local/bin/kube-proxy, /opt/bin/flanneld