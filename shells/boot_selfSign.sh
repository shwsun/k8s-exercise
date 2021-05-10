# input pass phrase two times 
sudo openssl genrsa -aes256 -out /etc/pki/tls/private/k8s-rootca.key 2048
sudo chmod 600  /etc/pki/tls/private/k8s-rootca.key  
cat << EOF | sudo tee /etc/pki/tls/private/k8s-openssl.conf
[req]
default_bits = 2048
default_md = sha1
default_keyfile = k8s-rootca.key
distinguished_name = req_distinguished_name
#extensions = v3_ca
req_extensions = v3_ca
[v3_ca]
basicConstraints = critical, CA:TRUE, pathlen:0
subjectKeyIdentifier = hash
keyUsage = keyCertSign, cRLSign
nsCertType = sslCA, emailCA, objCA
[req_distinguished_name]
countryName = KR
countryName_default = KR
countryName_min = 2
countryName_max = 2
organizationName = SKCC
organizationName_default = SKCC
commonName = k8s
commonName_default = k8s Self Signed CA
commonName_max = 64
EOF

# input pass phrase & KR, SKCC, k8s confirm 
sudo openssl req -new -key /etc/pki/tls/private/k8s-rootca.key -out /etc/pki/tls/certs/k8s-rootca.csr -config /etc/pki/tls/private/k8s-openssl.conf 
# enter pass phrase 
sudo openssl x509 -req \
-days 3650 \
-extensions v3_ca \
-set_serial 1 \
-in /etc/pki/tls/certs/k8s-rootca.csr \
-signkey /etc/pki/tls/private/k8s-rootca.key \
-out /etc/pki/tls/certs/k8s-rootca.crt \
-extfile /etc/pki/tls/private/k8s-openssl.conf 
# -extfile /etc/pki/tls/private/k8s-openssl.conf

# openssl s_client -connect skcc.com:443 |tee certlog
# QUIT
# "BEGIN CERTIFICATE" and "END CERTIFICATE" 사이에 존재하므로 에디터로 직접 편집해도 됨
# openssl x509 -inform PEM -in certlog -text -out certdata
# openssl x509 -inform PEM -text -in certdata 
# sudo cat /home/vagrant/certdata >> /etc/pki/tls/certs/ca-bundle.crt 

# cert server 
# sudo yum install -y 

