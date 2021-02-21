# counter-flask

## Descripción de la aplicación.
Se trata de un contador escrito en python que muestra el numero de llamadas exitosas a la BDD redis y guarda en un JSON los logs de las llamadas exitosas y las fallidas. 

## Funcionamiento de la aplicación.
El html " / " hace una petición a la BDD Redis. Si es exitosa, muestra por pantalla un contador indicando el num. de peticiones existosas hasta el momento y guarda en los logs el success. En caso de fallo, reintenta realizar la petición hasta un máximo de 5 veces. Si no lo consigue, no aumenta el contador y guarda un log de failure.

/health/live 
/health/ready

## Instrucciones para ejecutarla en local
- Sitúate en directorio en el que se encuentra el dockerfile:
docker build -t [image name]:[tag] .  
docker-compose up
- Abre el navegador y accede a la app: 0.0.0.0:5000
  
## Instrucciones para desplegarla en Kubernetess
1. Create Secret
kubectl create secret generic credentials --from-literal=REDIS_PASSWORD=$PASSWORD
$PASSWORD=mypassword

3. Deploy en GKE con Kubernetes

- Crea y configura un clúster zonal en GKE: https://console.cloud.google.com/kubernetes/
- Conectate al cluster usando la terminal: 
gcloud container clusters get-credentials [nombre del clustter --zone [zone] --project [id proyecto]
- Implementa los manifests de k8s:
kubectl apply -f k8s  
