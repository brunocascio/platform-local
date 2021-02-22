export MINIKUBE_IP := $(shell minikube ip || true)
NODES := $(or ${NODES},1)

all:

minikube:
	@minikube start --cpus 4 --memory 8192 -n $(NODES)

addons:
	# Metallb
	@kustomize build k8s/addons/metallb | kubectl apply -f -
	# Istio
	@istioctl install -y --set profile=demo

cleanup-addons:
	@istioctl x uninstall --purge -y
	@kustomize build k8s/addons/metallb | kubectl delete -f -

deploy-jenkins:
	@kubectl apply -f k8s/jenkins/manifests
	@helm repo add jenkinsci https://charts.jenkins.io
	@helm repo update
	@helm upgrade --install jenkins jenkinsci/jenkins --namespace jenkins --create-namespace -f k8s/jenkins/jenkins-values.yaml

cleanup-jenkins:
	@helm uninstall jenkins --namespace jenkins >/dev/null || echo "Already uninstalled"
	@kubectl delete -f k8s/jenkins/manifests >/dev/null || echo "Already uninstalled"

deploy-example:
	@kustomize build apps/example | kubectl apply -f -

cleanup-example:
	@kustomize build apps/example | kubectl delete -f -

clean:
	@minikube delete

