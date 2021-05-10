# docker image tagging in host machine ...
#sudo docker pull nvcr.io/nvidia/tritonserver:20.12-py3
#sudo docker tag nvcr.io/nvidia/tritonserver:20.12-py3 shwsun/tritonserver:20.12-py3
#sudo docker push shwsun/tritonserver:20.12-py3
sudo docker pull shwsun/tritonserver:20.12-py3
sudo docker tag shwsun/tritonserver:20.12-py3 nvcr.io/nvidia/tritonserver:20.12-py3 


# https://developer.nvidia.com/blog/deploying-a-natural-language-processing-service-on-a-kubernetes-cluster-with-helm-charts-from-ngc/
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
# https://github.com/NVIDIA/nvidia-docker
# https://github.com/triton-inference-server/server


######## NVidia Toolkit ########
sudo dnf install -y tar bzip2 make automake gcc gcc-c++ vim pciutils elfutils-libelf-devel libglvnd-devel iptables
sudo yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo yum repolist -v
sudo yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.4.3-3.1.el7.x86_64.rpm
sudo yum install docker-ce -y
sudo systemctl --now enable docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
sudo yum clean expire-cache
sudo yum install -y nvidia-docker2
sudo systemctl restart docker
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi


##### bare metal ########
docker pull nvcr.io/nvidia/tritonserver:20.09-py3
docker run --rm -ti -v<path-to-models/triton>:/models nvcr.io/nvidia/tritonserver:20.09-py3 tritonserver --model-repository=/models --strict-model-config=false
#tritonserver --model-repository=/path/to/model/repository
###
lsblk
vgdisplay
fdisk -l /dev/nvme0n1
df -k 
lvmdiskscan

vgdisplay -C 
pvdisplay -C









