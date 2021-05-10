sudo systemctl start nexus
sudo cat /app/sonatype-work/nexus3/admin.password 
# 인증서용 pem 추출
#cd ~ 
#sudo keytool -printcert -rfc -sslserver skcc.com:443 > skcc.pem
# Getting a Remote Certificate Through A HTTP Proxy Server
# keytool -J-Dhttps.proxyHost=<proxy_hostname> -J-Dhttps.proxyPort=<proxy_port> -printcert -rfc -sslserver <remote_host_name:remote_ssl_port>
#keytool -J-Dhttps.proxyHost=skcc.com -J-Dhttps.proxyPort=443 -printcert -rfc -sslserver k8s.gcr.io:443

# Inbound HTTPS Nexus
# wrapper.conf > jetty-https.xml enable
# ? /app/sonatype-work/nexus3/etc > nexus.properties : application-port-ssl=8443