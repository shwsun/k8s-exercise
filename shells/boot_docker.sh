# (도커 CE 설치)
## 리포지터리 설정
### 필요한 패키지 설치
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

## 도커 리포지터리 추가
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#sudo yum-config-manager --save --setopt=kubernetes.sslverify=false
sudo yum repolist

# 도커 CE 설치
sudo yum update -y && sudo yum install -y containerd.io-1.2.13 docker-ce-19.03.11 docker-ce-cli-19.03.11

## /etc/docker 생성
sudo mkdir /etc/docker

# 도커 데몬 설정
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

# /etc/systemd/system/docker.service.d 생성
sudo mkdir -p /etc/systemd/system/docker.service.d

# 도커 재시작
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker



