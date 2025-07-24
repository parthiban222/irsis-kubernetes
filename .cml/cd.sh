#!/bin/bash
set -e

echo "🔧 Building Docker image..."
docker build -t iris-api docker_version/

echo "🏷️ Tagging image for Google Artifact Registry..."
docker tag iris-api us-central1-docker.pkg.dev/ageless-aura-461314-a1/my-repo/iris-api:latest

echo "🚀 Pushing image to Artifact Registry..."
docker push us-central1-docker.pkg.dev/ageless-aura-461314-a1/my-repo/iris-api:latest

echo "♻️ Updating Kubernetes deployment image..."
kubectl set image deployment/iris-workload iris-api=us-central1-docker.pkg.dev/ageless-aura-461314-a1/my-repo/iris-api:latest --namespace=default

echo "✅ Deployment updated with new image!"

