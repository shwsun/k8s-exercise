#SK_SSL.crt 를 신뢰에 추가
# sudo keytool -importcert -file SK_SSL.crt -alias sk -keystore cacerts
# 비밀번호 기억해야. 2201tjs!00
# sudo mkdir /usr/local/share/ca-certificates/extra
# sudo cp root.cert.pem /usr/local/share/ca-certificates/extra/root.cert.crt
# sudo update-ca-certificates

# vagrant plugin ssl error. 다른 도구 에러 없을 시.. vag 자체 CA 파일 사용 때문.
# /usr/share/pki/ca-trust-source/anchors/ 또는 /etc/ssl.... 에 crt 옮기고
# update-ca-trust 실행
# sudo mv cacert.pem cacert.pem.old
# sudo ln -s /etc/ssl/certs/ca-certificates.crt /opt/vagrant/embedded/cacert.pem

sudo yum install -y curl policycoreutils-python openssh-server openssh-clients

sudo systemctl enable sshd 
sudo systemctl start sshd


# sudo firewall-cmd --permanent --add-service=http 
# sudo firewall-cmd --permanent --add-service=https 
# sudo systemctl reload firewalld
# firewalld 비활성화  
sudo systemctl stop firewalld
sudo systemctl disable firewalld




#sudo ./gitlab.script.rpm.sh
# [gitlab_gitlab-ce]
# name=gitlab_gitlab-ce
# baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/7/$basearch
# repo_gpgcheck=1
# gpgcheck=1
# enabled=1
# gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
#        https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey/gitlab-gitlab-ce-3D645A26AB9FBD22.pub.gpg
# sslverify=1
# sslcacert=/etc/pki/tls/certs/ca-bundle.crt
# metadata_expire=300

# [gitlab_gitlab-ce-source]
# name=gitlab_gitlab-ce-source
# baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/7/SRPMS
# repo_gpgcheck=1
# gpgcheck=1
# enabled=1
# gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
#        https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey/gitlab-gitlab-ce-3D645A26AB9FBD22.pub.gpg
# sslverify=1
# sslcacert=/etc/pki/tls/certs/ca-bundle.crt
# metadata_expire=300

# rpm -Uvh gitlab-ce-<version>.rpm
# sudo yum install gitlab-ce-13.8.1-ce.0.el7.x86_64
sudo EXTERNAL_URL="192.168.56.22:9001" yum install -y gitlab-ce-13.8.1-ce.0.el7.x86_64.rpm

# 설정 변경. 초기 id root
#sudo vi /etc/gitlab/gitlab.rb



# ip addr 에서 ip 추출하는 스크립트로 변경해야. 
# 또는 호스트 네임 이용한 도메인 이름 형태로.



