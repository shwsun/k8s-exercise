sudo yum install -y python3 
sudo unlink /bin/python
sudo ln -s /bin/python3.6 /bin/python3
sudo ln -s /bin/python3.6 /bin/python
sudo ln -s /bin/pip3.6 /bin/pip
#sed -i 's/{ORIGINAL}/{CHANGE}/g' {FILE_NAME}
sudo sed -i 's/#!\/usr\/bin\/python/#!\/usr\/bin\/python2/g' /usr/bin/yum
sudo sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2/g' /usr/libexec/urlgrabber-ext-down
# sudo cat /usr/libexec/urlgrabber-ext-down
# !/usr/bin/python2 
#sudo vi /usr/libexec/urlgrabber-ext-down
# !/usr/bin/python2
sudo pip install --upgrade setuptools pip
sudo yum install -y gcc gcc-c++ libffi-devel python3-devel python3-pip python3-wheel openssl-devel cyrus-sasl-devel openldap-devel

# python, pip, yum 모두 정상 작동하는 지 확인 
python --version
pip --version
yum --version 

