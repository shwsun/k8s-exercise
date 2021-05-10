# Prometheus
[Prometheus & Node-Exporter](https://twofootdog.tistory.com/17?category=845779)

쿠버네티스 클러스터에 프로메테우스 모니터링을 적용하기 위해선 다음과 같은 리소스가 필요하다.  

- cluster-role : 프로메테우스 컨테이너가 쿠버네티스 api에 접근할 수 있는 권한을 부여한다.  
- config-map : 프로메테우스가 기동되려면 프로메테우스 환경설정파일(prometheus.rules, prometheus.yaml)이 필요한데, 해당 환경설정파일을 정의해줌. 프로메테우스 컨테이너가 기동되면 config-map에 정의된 prometheus.yaml이 컨테이너 내부로 들어가게 된다. prometheus.rules에는 수집한 지표에 대한 알람조건을 지정하여 특정 조건이 되면 prometheus에서 AlertManager로 알람을 보낼 수 있고, prometheus.yaml에는 수집할 지표(Metric) 종류, 지표 수집 주기 등을 기입한다.   
- deployment : 프로메테우스 deployment로 pod 가 구동될 때 필요하다.  
- service : 컨테이너 외부에서 프로메테우스로 접근하기 위해 필요하다.  
daemonset(node-exporter) : 쿠버네티스 클러스터 정보를 수집하기 위해 node-exporter가 필요하며 해당 exporter는 각 노드당 1개씩만 올라가기 때문에 daemonset 타입으로 구동시킨다.  

```bash
kubectl create ns monitoring
kubectl apply -f prometheus-cluster-role.yaml
kubectl apply -f prometheus-config-map.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-svc.yaml
kubectl apply -f prometheus-node-exporter.yaml
```
<host ip : nodePort>  
then, type `http://192.168.56.15:30003` in web browser.  
you can skip execution 'prometheus-node-exporter.yaml'.  
