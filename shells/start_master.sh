# run : 1 ip, 2 user
IP_ADDR=$1
MAIN_USER=$2
MASTER_NODE=$3
echo $IP_ADDR 
echo $MAIN_USER
echo $MASTER_NODE
export HOME=/home/$MAIN_USER
echo "===== kubeadm inited. admin.conf setted in $HOME ====="
sudo swapoff -a
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.10
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$IP_ADDR

# 테스트 : user 계정으로 실행하는 경우. 아래와 같이 config 수정한 경우에는 sudo로 실행하면 에러 발생한다. 

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
# #sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo chown $MAIN_USER:$MAIN_USER $HOME/.kube/config
# kubectl get nodes 

# # pod network 설치. 임시.
# sudo docker login -u shwsun -p 0654Tjs!
# sudo docker pull shwsun/flannel:v0.13.1-rc1
# sudo docker image tag shwsun/flannel:v0.13.1-rc1  quay.io/coreos/flannel:v0.13.1-rc1
kubectl apply -f  $HOME/yml/kube-flannel.yml
kubectl taint nodes $MASTER_NODE node-role.kubernetes.io/master-

# node join 용 key 출력
#kubeadm token list 
# k8s 전체 정지 어려워서 시스템 강제 정지 
# sudo systemctl halt 