# tagging k8s.gcr.io/ingress-nginx/controller:v0.44.0
sudo docker pull shwsun/ingress-nginx:v0.44.0
sudo docker image tag shwsun/ingress-nginx:v0.44.0 k8s.gcr.io/ingress-nginx/controller:v0.44.0

kubectl apply -f ./yml/kube-ingress-nginx-deploy.yml
#kubectl apply -f ./ingress.yml
kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --watch

# from docker hub, download ngress-nginx-controller  
#sudo docker pull k8s.gcr.io/ingress-nginx/controller:v0.44.0
# https://artifacthub.io/packages/search?page=1&ts_query_web=ingress-nginx

# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update
# #helm install isngres-nginx ingress-nginx-3.23.0
# helm install ingres-nginx ingress-nginx/ingress-nginx

cat <<EOF | sudo tee minimal-ingress.yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /testpath
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
EOF

# 
cat <<EOF | sudo tee ingress-resource-backend.yml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-resource-backend
spec:
  defaultBackend:
    resource:
      apiGroup: k8s.example.com
      kind: StorageBucket
      name: static-assets
  rules:
    - http:
        paths:
          - path: /icons
            pathType: ImplementationSpecific
            backend:
              resource:
                apiGroup: k8s.example.com
                kind: StorageBucket
                name: icon-assets
EOF

# kubectl describe ingress ingress-resource-backend

kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test-ingress
spec:
  defaultBackend:
    service:
      name: test
      port:
        number: 80
EOF


# Fan out test 
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: simple-fanout-example
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - path: /foo
        pathType: Prefix
        backend:
          service:
            name: service1
            port:
              number: 4200
      - path: /bar
        pathType: Prefix
        backend:
          service:
            name: service2
            port:
              number: 8080
EOF
# kubectl describe ingress simple-fanout-example


