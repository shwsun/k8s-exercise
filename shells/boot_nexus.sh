# sudo docker load --input nexus-3.29.2-02-unix.tar
# sudo docker pull sonatype/nexus3
# sudo docker run -d -p 8081:8081 --name nexus sonatype/nexus3 
# sudo docker stop --time=120 nexus
# sudo docker run -itd -p 8081:8081 -p 51001:51001 -v /home/vagrant/nexus_data:/nexus-data --name mynexus sonatype/nexus3
# sudo docker stop --time=120 mynexus
# sudo docker exec -it nexus /bin/bash

# sudo sysctl -w net.ipv6.conf.all.forwarding=1
# sudo sysctl -w net.ipv4.conf.all.forwarding=1
# curl http://localhost:8081/
# curl: (56) Recv failure: Connection reset by peer 
# sudo docker stop mynexus
# sudo docker container rm mynexus
# sudo docker run -it -p 8081:8081 --name mynexus -d sonatype/nexus3
# sudo docker container attach mynexus
#################
# keytool -printcert -rfc -sslserver skcc.com:443 > skcc.pem
sudo docker pull sonatype/nexus3
sudo docker run -itd -p 8081:8081 -p 51001:51001 -v /home/vagrant/nexus_data:/nexus-data --name nexus sonatype/nexus3

