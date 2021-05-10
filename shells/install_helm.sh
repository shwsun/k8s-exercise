# download helm chart tar.gz and deflate it.
curl -o helm.tar.gz --insecure https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
tar -xf helm.tar.gz
cd linux-amd64
# copy 
sudo cp helm /usr/local/bin/helm
cd ~ 
# helm repo update
helm repo add stable https://charts.helm.sh/stable
