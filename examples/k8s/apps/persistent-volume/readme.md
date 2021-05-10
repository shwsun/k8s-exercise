## pre-requisite
1. connect to k8s vm console 
1. create `mnt` folder in user home directory  
2. create k8s yaml file  
  

## 1. create volume
```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-storage
  local:
    path: /home/vagrant/mnt
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - k8s2
EOF
```

## 2. create pod  

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pod-test-01
spec:
  containers:
    - name: uses-hello-image
      image: hello-world
      imagePullPolicy: IfNotPresent
  restartPolicy: Never
EOF
# wait a minute...
kubectl logs pod-test-01
```



kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: pod-test-02
spec:
  containers:
    - name: uses-helloweb-image
      image: nginxdemos/hello
      imagePullPolicy: IfNotPresent
  restartPolicy: Never
EOF