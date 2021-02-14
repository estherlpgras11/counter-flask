# flask-counter

## Descripción de la aplicación.
Se trata de un contador escrito en python que muestra el numero de llamadas exitosas a la BDD redis y guarda en un JSON los logs de las llamadas exitosas y las fallidas. 

## Funcionamiento de la aplicación.
El html " / " hace una petición a la BDD Redis. Si es exitosa, muestra por pantalla un contador indicando el num. de peticiones existosas hasta el momento y guarda en los logs el success. En caso de fallo, reintenta realizar la petición hasta un máximo de 5 veces. Si no lo consigue, no aumenta el contador y guarda un log de failure.

/health/live 

/health/ready

## Requisitos para hacerla funcionar. 


## Instrucciones para ejecutarla en local 


## Instrucciones para desplegarla en Kubernetess