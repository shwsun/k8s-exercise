# 확인을 위해 pod 로 먼저 주피터 노트북을 올려 봅니다. 
# 호스트 머신의 /mnt/data/notebook 폴더를 Persistent Volume 으로 사용합니다. 
# 주피터 노트북 파드에서 실행한 결과는 파드 종료 후에도 호스트에 남아 있습니다. 
# 공유 볼륨에 미리 적재 해 둔 파일을 이용해 노트북을 실행할 수도 있습니다. 
# /mnt/data/notebook/test.ipynb 파일 존재.
cat <<EOF >./jupyter_pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: jupyter
spec:
  containers:
  - image: jupyter/datascience-notebook
    name: jupyter-nb
    volumeMounts:
    - name: notebook
      mountPath: /home/jovyan/work
      #readOnly: true
    ports:
    - containerPort: 80
      protocol: TCP
  volumes:
  - name : notebook
    hostPath:
      path: /mnt/data/notebook
      type: Directory
EOF