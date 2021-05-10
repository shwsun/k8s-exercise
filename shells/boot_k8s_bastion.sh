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
# cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
# [kubernetes]
# name=Kubernetes
# baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
# enabled=1
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
# EOF

sudo yum-config-manager --save --setopt=kubernetes.sslverify=false


# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config


export RPM_DIR=/home/vagrant/RPM_DIR
# openssl s_client -showcerts -connect packages.cloud.google.com:443
# Self-Signed Root CA 인증서 생성
# 아래 설치시 repo https 연결시 인증 에러 발생하기 때문. 
yumdownloader --assumeyes --destdir=$RPM_DIR --resolve yum-utils kubeadm-1.18.14 kubelet-1.18.14 kubectl-1.18.14 ebtables
sudo yumdownloader --assumeyes --destdir=$RPM_DIR --resolve kubeadm-1.20.* kubelet-1.20.* kubectl-1.20.*
sudo yumdownloader --assumeyes --destdir=$RPM_DIR --resolve kubeadm kubelet kubectl

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

# firewalld 비활성화  
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#스왑 오프
sudo swapoff -a
