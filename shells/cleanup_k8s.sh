echo "============= K8S shutdown hook ============="
echo "============= K8S all resources are cleared ============="
#kubeadm reset 
su -
# etcd + kube
systemctl stop kubelet
for CONTAINER in $(docker ps --format "{{.Names}}"|grep "^k8s_") ; do
    docker rm $(docker stop $(docker ps -a -q --filter name=$CONTAINER --format="{{.ID}}"))
done
killall -9 kubectl 
systemctl stop docker
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /run/flannel
rm -rf /etc/cni/
rm -rf /etc/kubernetes
rm -rf /var/lib/etcd/
ip link delete cni0
ip link delete flannel.1
# for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler kube-proxy flanneld; do
#     #systemctl stop $SERVICES
# done
systemctl start docker


