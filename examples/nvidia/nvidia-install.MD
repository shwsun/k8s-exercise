# NVIDIA GPU 환경 설치
## Bare Metal 
1. graphic driver install - https://www.nvidia.com/download/index.aspx?lang=en-us
2. CUDA Toolkit 
3. CUPTI 
4. cuDNN SDK


1. NVIDIA Graphic Driver 
.run install 시 중간에 오류로 복구해야 하는 경우가 자주 발생하고, 복구가 어렵다.  

CentOS7, 64 bit. Geforce 1050 Ti Notebook  
https://us.download.nvidia.com/XFree86/Linux-x86_64/460.39/NVIDIA-Linux-x86_64-460.39.run
LINUX X64 (AMD64/EM64T) DISPLAY DRIVER
 
Version:	460.39
Release Date:	2021.1.26
Operating System:	Linux 64-bit
Language:	English (US)
File Size:	170.05 MB

--> cuda 설치시 rpm 에서 460.32 nvidia driver latest로 설치 됨.   
  
chmod 755  etc/NVIDIA-Linux-x86_64-460.39.run
nvidia install 는 root 로 실행해야 한다.   
설치 중 화면이  CLI 모드로 변경되므로, 실행 중이던 프로그램을 종료하고 실행한다.  
```bash
########################
# 1. install nvidia graphic driver 
# root  계정으로 실행해야 함. 
########################
yum -y install gcc gcc-c++ make binutils libtool autoconf automake patch pkgconfig redhat-rpm-config gettext
yum install -y kernel-devel kernel-headers gcc make
yum install -y epel-release
yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r) dkms
# nouveau 비활성화
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
cat <<EOF > /etc/modprobe.d/nvidia-installer-disable-nouveau.conf 
blacklist nouveau
options nouveau modeset=0
EOF

reboot 

cd /boot
# boot 정보 백업 
mv -f initramfs-$(uname -r).img{,_backup}
# nouveau disable 한 설정으로 부트 정보 재생성 
dracut
# 부트 정보 다시 생성되었는 지 확인 
ls initramfs-$(uname -r).img
# X 윈도우 모드로는 그래픽 드라이버 설치 안 됨.  X 윈도우 종료. 
systemctl isolate multi-user.target
# 프로젝트 경로 etc 폴더에 다운 받아둔 드라이버 설치 파일 실행 
etc/NVIDIA-Linux-x86_64-460.39.run
# 설치 끝나고 reboot 실행하고 나서 정상 설치 여부를 엔비디아 정보 확인. 
nvidia-smi
nvidia-settings
# nvidia-settings --ctrl-display=CTRL-DISPLAY 
# echo $DISPLAY
# nvidia-settings -V -c :0
# lsmod | egrep -i "nvidia|nouveau"
```



Try this:
Create /etc/X11/xorg.conf.d/11-nvidia.conf with contents
```bash
cat <<EOF > /etc/X11/xorg.conf.d/11-nvidia.conf
Section "OutputClass"
  Identifier "nvidia"
  MatchDriver "nvidia-drm"
  Driver "nvidia"
  Option "AllowEmptyInitialConfiguration" "true"
  Option "PrimaryGPU" "true"
EndSection
EOF
```
and for GDM/Gnome, create two files optimus.desktop in /etc/xdg/autostart/ and /usr/share/gdm/greeter/autostart/ containing  

```bash
cat <<EOF > /etc/xdg/autostart/optimus.desktop
[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer
EOF
cat <<EOF > /usr/share/gdm/greeter/autostart/optimus.desktop
[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer
EOF
```


2. CUDA  
CUDA Tensor version check  
https://www.tensorflow.org/install/source#tested_build_configurations
tensorflow_gpu-2.1.0  ~ 2,3.0 . CUDA : 10.1 , cuDNN : 7.6 

CUDA : 10.1 
NVIDA CUDA Toolkit Archive 링크: https://developer.nvidia.com/cuda-toolkit-archive
  
wget https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
chmod 755 cuda_10.1.243_418.87.00_linux.run
sudo sh cuda_10.1.243_418.87.00_linux.run
  
Fail log :   
/var/log/cuda-installer.log for details.   
Executing NVIDIA-Linux-x86_64-418.87.00.run --ui=none --no-questions --accept-license --disable-nouveau --no-cc-version-check --install-libglvnd  2>&1  
Finished with code: 256  
bios에서 secure boot를 disable
  
3. cuDNN 
cuDNN : 7.6 
NVIDIA cuDNN Archive 링크: https://developer.nvidia.com/rdp/cudnn-archive  
https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.1_20191031/RHEL7_3-x64/libcudnn7-7.6.5.32-1.cuda10.1.x86_64.rpm?ib9faXVMXtzgxeIvCjFlJICO_cwJu8b1tOS_NuZXdPpvMR9-tBbjqCRPFo2kbQ25NIytguJ3kUlzDw6f_kbMZv-qOyUmDbAw1QISp26apNJ8tEE6CAzovS6PnzUnGFZ8ogE-mF4cWhwUZNFYBWqias-Fe_pvmh2mnJU3cbl-041g1KEVwZOIsCo0xK2VGSHb3SHcdhaS6lOdB6ywVKO9w5t8zxixvUTq7Pnvf0MEJRi3lwkm5evDhsth_A  

cuDNN : 7.6.4 linux x64 library  
https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/7.6.4.38/Production/10.1_20190923/cudnn-10.1-linux-x64-v7.6.4.38.tgz?5SrW5ozlTMxJSUJ6dYBAzUVTqO9B34XwqldqNZFqopVaCNLzfTl0I1rGvg51M0pdkdiAl9tk45ct3gpvgBld79Qm30HNxFo2NEJZaJBMeRL4Yt5vMiYWQPs1Mp_tCpUBRBdX7BX8YfnHUFAeWKEmtkNs_oChYZFDSgrk1SnAc3HRmP4vwZRuZDO-jE1kyfw0JNNn20tySQnkRRx04-ru3YW_FwfULCW2Jw
Fail log  
Executing NVIDIA-Linux-x86_64-418.87.00.run --ui=none --no-questions --accept-license --disable-nouveau --no-cc-version-check --install-libglvnd  2>&1



---   
## .run 이외 설치
  
```bash 
sudo yum clean all
sudo yum install -y kernel | grep -q 'already installed' || sudo reboot  
#sudo yum install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)

# cuda repo 
#sudo yum install http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.0.130-1.x86_64.rpm
sudo yum install -y http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.1.243-1.x86_64.rpm
# sudo yum install -y epel-release
sudo yum clean all
sudo yum install -y cuda

```
---  
## Tensorflow Docker Jupyter
```bash
 docker pull tensorflow/tensorflow:latest  # Download latest stable image
 docker run -it -p 8888:8888 tensorflow/tensorflow:latest-jupyter  # Start Jupyter server 
 ```

## Bare Metal Jupyter Tensor 확인
user 계정으로 실행.  
shells/install_python3.sh 실행.  
```bash 
# 파이썬3 설치
~/src/poc/shells/install_python3.sh 
# 주피터 설치
sudo pip install notebook
cd ~ 
jupyter notebook --generate-config
#vi .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = ''" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.allow_origin = '*'" >> .jupyter/jupyter_notebook_config.py  

# 주피터 실행 
jupyter notebook  --ip='*' --NotebookApp.token='' --NotebookApp.password=''
```
노트북에서 아래와 같이 실행해서 확인

```python
# pip install tensorflow  
import tensorflow as tf
# 사용 장치 확인
tf.debugging.set_log_device_placement(True)

# 텐서 생성
a = tf.constant([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])
b = tf.constant([[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]])
c = tf.matmul(a, b)
print(c)
```  


