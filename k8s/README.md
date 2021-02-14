# Ejercicio redis

# Persistencia en redis

```
docker run --name some-redis -d redis redis-server --appendonly yes
```


```
apiVersion: v1
kind: Service
metadata:
  name: redis
spec:
  ports:
    - port: 6379
      name: redis
  clusterIP: None
  selector:
    app: redis
---
apiVersion: apps/v1beta2
kind: StatefulSet
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis  # has to match .spec.template.metadata.labels
  serviceName: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis  # has to match .spec.selector.matchLabels
    spec:
      containers:
        - name: redis
          image: redis:3.2-alpine
          imagePullPolicy: Always
          args: ["--requirepass", "$(REDIS_PASS)"]
          ports:
            - containerPort: 6379
              name: redis
          env:
          - name: REDIS_PASS
            valueFrom:
              secretKeyRef:
                name: env-secrets
                key: REDIS_PASS
```

## Redis password
```
redis.Connection(host='localhost', port=6379, db=0, password=None,
                 socket_timeout=None, socket_connect_timeout=None,
                 socket_keepalive=False, socket_keepalive_options=None,
                 socket_type=0, retry_on_timeout=False, encoding='utf-8',
                 encoding_errors='strict', decode_responses=False,
                 parser_class=DefaultParser, socket_read_size=65536,
                 health_check_interval=0):
```