sudo yum install -y wget 
# 네트웍 느려서 직접 다운로드 받다 실패. 
# https://www.apache.org/dyn/closer.lua?path=/nifi/1.12.1/nifi-1.12.1-bin.tar.gz
wget https://archive.apache.org/dist/nifi/1.12.0/nifi-1.12.0-bin.tar.gz
sudo yum install java-1.8.0-openjdk.x86_64 -y
# readlink -f /bin/javac


tar xvfz nifi-1.12.0-bin.tar.gz
#vi nifi-1.12.0/bin/nifi-env.sh
# export JSVA_HOME 

# $ firewall-cmd --zone=public --add-port=8000/tcp --permanent
# success
# $ firewall-cmd --zone=public --add-port=8080/tcp --permanent
# success

# $ firewall-cmd --reload
# $ firewall-cmd --list-all

#  $ ./nifi-1.12.0/bin/nifi.sh start
#  $ bin/nifi.sh status
#  http://본인의ip주소:8080/nifi/