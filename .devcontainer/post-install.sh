#!/bin/bash
set -x

# Install k3d if not already installed
if ! command -v k3d &> /dev/null; then
    echo "Installing k3d..."
    curl -Lo ./k3d https://github.com/k3d-io/k3d/releases/download/v5.6.0/k3d-linux-$(go env GOARCH)
    chmod +x ./k3d
    mv ./k3d /usr/local/bin/k3d
else
    echo "k3d is already installed"
fi

# Install kubebuilder if not already installed
if ! command -v kubebuilder &> /dev/null; then
    echo "Installing kubebuilder..."
    curl -L -o kubebuilder https://go.kubebuilder.io/dl/latest/linux/$(go env GOARCH)
    chmod +x kubebuilder
    mv kubebuilder /usr/local/bin/
else
    echo "kubebuilder is already installed"
fi

# Install kubectl if not already installed
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -LO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/$(go env GOARCH)/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/kubectl
else
    echo "kubectl is already installed"
fi

echo "Checking installed versions..."
k3d version
kubebuilder version
docker --version
go version
kubectl version --client