# metalLB 이용하는 방식도 확인...
export HOME=/home/vagrant
# deploy dashboard
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# kubectl apply -f kubernetes-dashboard.yaml
# kubectl proxy
kubectl apply -f $HOME/yml/kube-dashboard.yml
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
#http://192.168.56.10:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login


################
# 프락시 설정까지 완료하고 웹 열어서 Skip 연결하면 아래와 같은 에러 15개. 
# events is forbidden: User "system:serviceaccount:kubernetes-dashboard:kubernetes-dashboard"
#  \ cannot list resource "events" in API group "" in the namespace "default"


#kubectl create -f $HOME/yml/dashboard-admin.yml


# Create Service Account 
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
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# get token 
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

cat <<EOF | kubectl apply -f -
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://192.168.56.10
  name: scratch
contexts:
- context:
    cluster: scratch
    namespace: default
    user: exp
  name: exp-scratch
current-context: ""
kind: Config
preferences: {}
users:
- name: exp
  user:
    password: 1234
    username: exp
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
