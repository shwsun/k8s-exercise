kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl get deployments
kubectl get pods
kubectl get events
kubectl config view

kubectl expose deployment hello-node --type=LoadBalancer --port=8080
kubectl get services
kubectl proxy


export POD_NAME=hello-node-7567d9fdc9-fxrkp
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/
curl http://192.168.56.10:8080/api/v1/namespaces/default/pods/$POD_NAME/proxy/
kubectl exec -ti $POD_NAME bash

