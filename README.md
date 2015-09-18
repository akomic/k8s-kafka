# k8s-kafka

Kafka container on Kubernetes

Edit controller.yaml and change ZOOKEEPER_CONNECT environment to point to
Zookeeper instances configuration of which is not the scope of this
document. List of Zookeepers is comma-separated list e.g. host:port, host:port ...

Unique machine id required by Kafka configuration is generated from the ip
address of the container every time container is started.

## Service

```
kubectl create -f service.yaml
```

## Controller

```
kubectl create -f controller.yaml
```

## Verify

We are expecting one service with the name kafka created
```
kubectl get services
```

One replication controller expected
```
kubectl get rc
```

One running pod expected. This one is created by the controller.
```
kubectl get pods
```

To spawn 3 kafka pods
```
kubectl scale rc kafka --replicas=3
```

PS: This idea is based on graemej kafka image.