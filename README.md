# Test Platform running on K8s

## Prerequisites

Before start, you need to install the following packages:

- Docker
- Minikube
- Kubectl client
- Kustomize
- Istioctl

## Let's Start

### Runing a k8s cluster locally (only run once)

```
make minikube addons
```

If you want to cleanup addons, you can run 

```
make cleanup-addons
```

### (Optional) Deploy example app

```
make deploy-example
```

Example app is accesible via: http://example.192.168.49.2.sslip.io

If you want to cleanup the example app, you can run 

```
make cleanup-example
```

### (Optional) Running jenkins locally

```
make deploy-jenkins
```

Jenkins is accesible via: http://jenkins.192.168.49.2.sslip.io

If you want to cleanup jenkins, you can run 

```
make cleanup-jenkins
```

## Cleanup

Delete the whole cluster

```
make clean
```