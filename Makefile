all:

minikube:
	@minikube start

jenkins:
	@kubectl apply -f k8s/jenkins/manifests
	@helm repo add jenkinsci https://charts.jenkins.io
	@helm repo update
	@helm upgrade --install jenkins jenkinsci/jenkins --namespace jenkins --create-namespace -f k8s/jenkins/jenkins-values.yaml

cleanup-jenkins:
	@helm uninstall jenkins --namespace jenkins >/dev/null || echo "Already uninstalled"
	@kubectl delete -f k8s/jenkins/manifests >/dev/null || echo "Already uninstalled"

clean:
	@minikube delete

