sudo yum install -y python3 
# sudo pip3 install superset
# sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
# sudo yum install -y python36u python36u-libs python36u-devel python36u-pip
# which python3.6
# ls -l /bin/python*
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
sudo pip install apache-superset dataclasses
/usr/local/bin/superset db upgrade

# Create an admin user (you will be prompted to set a username, first and last name before setting a password)
export FLASK_APP=superset
#superset fab create-admin
/usr/local/bin/superset fab create-admin --username admin \
              --firstname Superset \
              --lastname Admin \
              --email seonho.shin@samyang.com \
              --password 2201tjs0

echo ">>>> superset fab create-admin <<<<"
# Load some data to play with. admin, user 
/usr/local/bin/superset load_examples
# Create default roles and permissions
/usr/local/bin/superset init
echo ">>>> superset inited <<<<"
# /usr/local/bin/superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger

# # Set SELinux in permissive mode (effectively disabling it)
# sudo setenforce 0
# sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
# sudo systemctl stop firewalld
# sudo systemctl disable firewalld
# To start a development web server on port 8088, use -p to bind to another port
# superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger
#superset run -h 0.0.0.0 -p 8080
# sudo systemctl stop superset 
# sudo systemctl restart