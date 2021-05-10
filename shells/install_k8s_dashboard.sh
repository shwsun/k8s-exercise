# local 접속만 가능한 k8s Web Dashboard를 외부에서도 사용 가능하게 설치
# 기본 설치 파일을 일부 수정해서 kube-dashboard.yml 로 미리 만들어 두었다.  인증 Skip 기능 살려 둠. 
echo "== install dashboard =="
export HOME=/home/$1
echo $HOME
# 사용자 계정이어야 한다. 앞서 start_master 처리하면서 계정 전환하지 않았는 지 주의해야.
#export HOME=/home/$USER
kubectl apply -f $HOME/yml/kube-dashboard.yml

# # Create Service Account 
# cat <<EOF | kubectl apply -f -
# apiVersion: v1
# kind: ServiceAccount
# metadata:
#   name: admin-user
#   namespace: kubernetes-dashboard
# EOF

# # Creating a ClusterRoleBinding
# cat <<EOF | kubectl apply -f -
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRoleBinding
# metadata:
#   name: admin-user
# roleRef:
#   apiGroup: rbac.authorization.k8s.io
#   kind: ClusterRole
#   name: cluster-admin
# subjects:
# - kind: ServiceAccount
#   name: admin-user
#   namespace: kubernetes-dashboard
# EOF

# Creating a Service Account
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Creating a ClusterRoleBinding
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
---
#apiVersion: rbac.authorization.k8s.io/v1beta1
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: kubernetes-dashboard
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
EOF

# kind: Role
# apiVersion: rbac.authorization.k8s.io/v1
# metadata:
#   namespace: kubernetes-dashboard
#   name: kubernetes-dashboard
# rules:
# - apiGroups: [""] # "" indicates the core API group
#   resources: ["pods"]
#   verbs: ["get", "watch", "list"]

# node join 용 key 출력
kubeadm token list 
# 외부 ip로 접근 가능하게 proxy 설정.
kubectl proxy --address 0.0.0.0 --accept-hosts '.*' 
# 아래와 같은 URL로 브라우저를 띄우면 Web Dashboard 화면이 출력된다.  
# 단, 아직 권한 부여 전이라 접근할 수 없는 ... 에러 발생. 
#http://192.168.56.10:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
