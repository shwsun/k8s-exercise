# VM 에 직접 설치하는 버전
#sudo yum update -y
#sudo yum install wget -y

sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo mkdir /app && cd /app
#sudo wget -O --no-check-certificate nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo mv nexus-3.29.2-02-unix.tar.gz /app/nexus.tar.gz
sudo tar -xvf nexus.tar.gz
sudo mv nexus-3* nexus
sudo adduser nexus

sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work

#sudo vi  /app/nexus/bin/nexus.rc
#run_as_user="nexus" 

cat <<EOF | sudo tee /app/nexus/bin/nexus.rc
run_as_user="nexus" 
EOF

cat <<EOF | sudo tee /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOF

sudo chkconfig nexus on
#sudo systemctl start nexus