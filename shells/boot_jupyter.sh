# sudo yum install -y docker
# sudo systemctl enable docker.service
# sudo systemctl start docker.service
# sudo docker pull kaggle/python:latest
# sudo docker run -v $PWD:/tmp/working -w=/tmp/working -p 8888:8888 --rm -it kaggle/python

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

#pip3 install jupyterlab
#conda install -c conda-forge notebook
sudo pip install notebook
cd /home/vagrant
sudo -u vagrant /usr/local/bin/jupyter notebook --generate-config
#vi .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = ''" >> .jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.allow_origin = '*'" >> .jupyter/jupyter_notebook_config.py



