################################################
######## centos 7 tensorflow setting using nvidia gpu  
# 1. install nvidia graphic driver 
#  --> in host Docker GPU enabled
#  --> (for vm : enabel cpu virtualization) 
# 2. CUDA Toolkit install
# 3. cuDNN install 
# 4. tensorflow gpu pip install 
#### for running in docker 
# docker version : 19.03.11 
# 5. nvidia container toolkit install : https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-centos-7-8
#### using nvidia docker 
#### CUDA info
# tensorflow-gpu==2.0.0-rc1
# CUDA 11.0
# docker version : 19.03.11 
################################################

######## nvidia installation check ########
yum install pciutils
lspci -k | grep -EA2 "VGA|3D"
glxinfo | grep NVIDIA
########################
# 1. install nvidia graphic driver 
########################
yum install kernel-devel kernel-headers gcc make
# nouveau 비활성화
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
cat <<HERE > /etc/modprobe.d/nvidia-installer-disable-nouveau.conf 
blacklist nouveau
options nouveau modeset=0
HERE

cd /boot
mv initramfs-$(uname -r).img{,_backup}
dracut
ls initramfs-$(uname -r).img
systemctl isolate multi-user.target
# download NVIDIA-Linux-x86_64-460.39.run
# chmod 755 ....
# ./NVIDIA-Linux-x86_64-460.39.run
# X window is halted and remaining procedure continue in console mode. 
# reboot and AMD cpu virtualization enabled in BIOS setup.

# view nvidia X server setting window 
nvidia-settings
## GPU monitoring 
nvidia-smi
watch -n 0.5 -d nvidia-smi
gpustat -i
# pip install glances[gpu]

########################
# --> run gpu enabled Docker in host machine
########################
su -
groupadd docker
usermod -aG docker $USER
newgrp docker 
########################
# 2. CUDA Toolkit install : 11.0
########################
wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run
sudo sh cuda_11.0.2_450.51.05_linux.run
export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64\ ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


########################
# 3. cuDNN install 
########################


# Docker in Docker GPU
# root 
docker run -v /var/run/docker.sock:/var/run/docker.sock \
    docker run --rm --gpus all \
    nvidia/cuda:11.0-base \
    nvidia-smi

## 
# 1. install nvidia driver 
# 2. install nvidia container toolkit
# 3. restart dockerd
# 4. run nvidia docker in docker 


## Nvidia driver install 
# root 
yum -y install gcc gcc-c++ make binutils libtool autoconf automake patch pkgconfig redhat-rpm-config gettext
yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r) dkms
yum -y install epel-release
# download driver : 3090 series 
https://kr.download.nvidia.com/XFree86/Linux-x86_64/460.39/NVIDIA-Linux-x86_64-460.39.run


fdisk -N 
pvdisplay
pvcreate /dev/nvme0n1
mount | grep /dev/mapper/centos-root
pvcreate /dev/nvme0n1p3
pvscan 
vgextend centos /dev/nvme0n1p3
vgextend centos /dev/nvme1n1p1
lvextend /dev/centos/root -l +25599

lvchange -a n cinder-volumes/volume-2a01973e-de1a-46df-877d-0fc6db05123f

lvchange -a n /dev/pts/0







