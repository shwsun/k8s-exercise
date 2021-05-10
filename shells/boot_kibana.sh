#sudo yum install -y wget
# https://artifacts.elastic.co/downloads/kibana/kibana-7.10.2-x86_64.rpm
# wget https://artifacts.elastic.co/downloads/kibana/kibana-7.10.2-x86_64.rpm
# shasum -a 512 kibana-7.10.2-x86_64.rpm 
sudo rpm --install kibana-7.10.2-x86_64.rpm

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
#  /etc/kibana/kibana.yml