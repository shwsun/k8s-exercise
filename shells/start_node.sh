sudo swapoff -a
MASTER_ADDR=$1
MAIN_USER=$2
echo $MASTER_ADDR 
echo ${MAIN_USER}

# # overwrite kube config as admin 
export HOME=/home/${MAIN_USER}
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# # #sudo chown $(id -u):$(id -g) $HOME/.kube/config
# sudo chown vagrant:vagrant $HOME/.kube/config

# pod 통신 위한 network 설정
# pod network 설치. 임시.
sudo docker pull shwsun/flannel:v0.13.1-rc1
sudo docker image tag shwsun/flannel:v0.13.1-rc1  quay.io/coreos/flannel:v0.13.1-rc1
sudo docker image rm -f shwsun/flannel:v0.13.1-rc1
#kubectl apply -f  $HOME/yml/kube-flannel.yml

# # master init 시 출력된 token 으로 대체
# export TOKEN=f19ksm.vlbm7iatyjt6tojk
# export CERT-HASH=sha256:317d91b7e24ff8de436dc765c90d29f43888dfc5f11d7c7fb9960d99f3fe3449
# sudo kubeadm join ${MASTER_ADDR} --token ${TOKEN} --discovery-token-ca-cert-hash ${CERT-HASH}

#sudo kubeadm join 192.168.56.15:6443 --token f19ksm.vlbm7iatyjt6tojk --discovery-token-ca-cert-hash sha256:317d91b7e24ff8de436dc765c90d29f43888dfc5f11d7c7fb9960d99f3fe3449 

