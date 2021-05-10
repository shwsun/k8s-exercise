git clone https://github.com/kubernetes/ingress-nginx.git
cd ./ingress-nginx/deploy/static/provider/baremetal
kubectl apply -f .
kubectl get deploy -n ingress-nginx
kubectl get svc -n ingress-nginx
curl levi.local.com:30431


