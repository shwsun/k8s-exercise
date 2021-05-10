sudo yum install java-1.8.0-openjdk.x86_64 -y

# cat <<EOF >/etc/yum.repos.d/elasticsearch.repo
# 인증서 문제 발생해서 download and install 처리
# cat  <<EOF | sudo tee /etc/yum.repos.d/elasticsearch.repo
# [elasticsearch-7.x]
# name=Elasticsearch repository for 7.x packages
# baseurl=https://artifacts.elastic.co/packages/7.x/yum
# gpgcheck=1
# gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
# enabled=1
# autorefresh=1
# type=rpm-md
# EOF
#sudo yum install -y elasticsearch

# Download and install the RPM manually 
# 파일 유효성 체크는 프람프트 자동화 처리 전에는 임시로 비활성화.
#sudo yum install -y wget 
# sudo yum install -y wget perl-Digest-SHA
#wget --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.9.3-x86_64.rpm
# wget --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-x86_64.rpm.sha512
# shasum -a 512 -c elasticsearch-7.10.2-x86_64.rpm.sha512 
sudo rpm --install elasticsearch-oss-7.9.3-x86_64.rpm
#ps -p 1 --> systemd 

# home dir : /usr/share/elasticsearch
# config dir : /etc/elasticsearch
# data dir : /var/lib/elasticsearch
# log dir : /var/log/elasticsearch

sudo echo "network.host: 0.0.0.0 " >> /etc/elasticsearch/elasticsearch.yml
sudo echo "http.port: 9200 " >> /etc/elasticsearch/elasticsearch.yml
sudo echo "transport.host: localhost " >> /etc/elasticsearch/elasticsearch.yml
sudo echo "transport.tcp.port: 9300 " >> /etc/elasticsearch/elasticsearch.yml

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service


# # Set SELinux in permissive mode (effectively disabling it)
# sudo setenforce 0
# sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
# # firewalld 비활성화  
# sudo systemctl stop firewalld
# sudo systemctl disable firewalld

#network.host: 192.168.0.1 -> 0.0.0.0

curl -X GET 'localhost:9200'
# curl -X GET '192.168.56.15:9200'


