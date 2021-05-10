# pod network 설치. 임시.
sudo docker pull shwsun/flannel:v0.13.1-rc1
sudo docker image tag shwsun/flannel:v0.13.1-rc1  quay.io/coreos/flannel:v0.13.1-rc1

# # run : start_master.sh 로 이동.
# sudo swapoff -a
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.10

# sudo kubeadm join 192.168.56.10:6443 --token 21aggo.a3sis5cbsqgbqs8j \
#    --discovery-token-ca-cert-hash sha256:fc4bc3b920f1fdb0d1ddd107ca04c095d3bbab699da32c53aea12766951f797c
# [ERROR] ... /etc/kubernetes/kubelet.conf already exists

# # 테스트 : user 계정으로 실행하는 경우. 아래와 같이 config 수정한 경우에는 sudo로 실행하면 에러 발생한다. 
# export HOME=/home/vagrant
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# # #sudo chown $(id -u):$(id -g) $HOME/.kube/config
# sudo chown vagrant:vagrant $HOME/.kube/config
# # kubectl get nodes 

# if run as root 
# export KUBECONFIG=/etc/kubernetes/admin.conf
# kubectl get nodes 
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml 
# quay.io/coreos/flannel:v0.13.1-rc1 
# image: quay.io/coreos/flannel:v0.13.1-rc1
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
