# Korifi Setup Guide

This guide provides tested steps to set up Korifi (Cloud Foundry on Kubernetes) on Kind for local development.

## Prerequisites

- Docker Desktop running
- kubectl installed  
- Kind installed
- jq (for JSON parsing)

## Step 1: Create Kind Cluster with Port Mappings

```bash
# Create cluster using the provided config
kind create cluster --name korifi --config install-korifi-kind.yaml

# Verify cluster is running
kubectl cluster-info
```

## Step 2: Install Korifi v0.15.1

```bash
# Install Korifi
kubectl apply -f https://github.com/cloudfoundry/korifi/releases/download/v0.15.1/korifi-0.15.1.tgz

# Wait for all components to be ready (this takes 5-10 minutes)
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=korifi-api -n korifi --timeout=600s
```

## Step 3: Fix kpack Buildpack Issues

**Important**: The default kpack installation may fail due to gcr.io authentication issues. Fix this:

```bash
# Replace with public kpack images
kubectl apply -f https://github.com/buildpacks-community/kpack/releases/download/v0.16.1/release-0.16.1.yaml

# Wait for kpack to be ready
kubectl wait --for=condition=Ready pod -l app=kpack-controller -n kpack --timeout=300s
```

## Step 4: Set Up API Access Permissions

```bash
# Grant cluster-admin permissions to korifi-api service account
kubectl create clusterrolebinding korifi-api-cf-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=korifi:korifi-api-system-serviceaccount
```

## Step 5: Verify Installation

```bash
# Check all Korifi pods are running
kubectl get pods -n korifi

# Test API endpoint
curl -ks https://localhost/v3/info

# Verify buildpack system is ready
kubectl get clusterbuilder -o wide
```

## Step 6: Test API Access with Token

```bash
# Get a service account token (valid for 1 hour)
TOKEN=$(kubectl create token korifi-api-system-serviceaccount -n korifi --duration=1h)

# Test API access
curl -ks https://localhost/v3/spaces/dev -H "Authorization: Bearer $TOKEN" | jq .

# Create a test app
cat > test-app.json << EOF
{
  "name": "test-app",
  "lifecycle": { 
    "type": "buildpack", 
    "data": { "stack": "paketo-buildpacks-stacks-jammy" } 
  },
  "relationships": { 
    "space": { "data": { "guid": "dev" } } 
  }
}
EOF

curl -ks -X POST https://localhost/v3/apps \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d @test-app.json | jq .
```

## Available Resources

- **Organization**: `system` (GUID: `system`)
- **Space**: `dev` (GUID: `dev`) 
- **API Endpoint**: `https://localhost`
- **Stack**: `paketo-buildpacks-stacks-jammy`


## Lifecycle Management

### Stopping the System
```bash
# Stop the Kind cluster (preserves state)
docker stop korifi-control-plane

# Or stop all Kind containers
docker stop $(docker ps -q --filter "label=io.x-k8s.kind.cluster=korifi")
```

### Starting After Restart
```bash
# Check if cluster exists
kind get clusters

# If cluster exists but stopped, start it
docker start korifi-control-plane

# Wait for cluster to be ready
kubectl cluster-info --context kind-korifi

# Verify all pods are running (may take 2-3 minutes)
kubectl get pods -n korifi
kubectl get pods -n kpack

# If RBAC was reset, re-apply permissions
kubectl get clusterrolebinding korifi-api-cf-admin || \
kubectl create clusterrolebinding korifi-api-cf-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=korifi:korifi-api-system-serviceaccount
```

### Persistence Notes
- **Kind clusters persist** across Docker Desktop restarts
- **All Korifi state** (apps, orgs, spaces) is preserved in the cluster
- **Only Docker Desktop restart** is needed - no need to reinstall Korifi
- **RBAC permissions** may need to be re-applied after cluster restart

### Quick Health Check
```bash
# Verify everything is working after restart
curl -ks https://localhost/v3/info
TOKEN=$(kubectl create token korifi-api-system-serviceaccount -n korifi --duration=1h)
curl -ks https://localhost/v3/spaces/dev -H "Authorization: Bearer $TOKEN"
```

### Complete Teardown
```bash
# Remove everything (cluster + Docker containers)
kind delete cluster --name korifi
docker system prune -f
```

## Clean Up

```bash
# Delete the entire cluster
kind delete cluster --name korifi
```
------

## Troubleshooting

### Pods Not Starting
```bash
kubectl get pods -A
kubectl describe pod <pod-name> -n <namespace>
```

### API Not Responding
```bash
# Check if ports are mapped correctly
docker ps | grep korifi

# Check API logs
kubectl logs -n korifi deployment/korifi-api-deployment
```

### Buildpack Issues
```bash
# Check kpack status
kubectl get clusterstore,clusterstack,clusterbuilder

# If failing, reinstall kpack with public images (Step 3)
```

### Permission Errors
```bash
# Ensure service account has proper permissions (Step 4)
kubectl get clusterrolebinding korifi-api-cf-admin
```

### CF CLI Authentication Issues (404 CF-NotFound)

**Problem**: CF CLI commands return `Error Code: 404, CF-NotFound, "Unknown request"`

**Root Cause**: Korifi v0.15.1 ships without UAA/OAuth by default. CF CLI expects `/oauth/token` endpoint.

**Symptoms**: 
```bash
cf7 auth admin password
# Returns: Error Code: 404, CF-NotFound, "Unknown request"

curl -k https://localhost/oauth/token
# Returns: 404
```

**Solutions**:
1. **Use token-based API access** (recommended - what this guide uses)
2. **Build cf-k8s-auth-plugin from source** (requires Go 1.20+)
3. **Enable UAA** (experimental flag doesn't actually deploy UAA in v0.15.1)

### kpack Buildpack Pull Failures

**Problem**: ClusterBuilder shows "ImagePullBackOff" or similar errors

**Root Cause**: Default kpack tries to pull from `gcr.io/cf-build-service-public` without authentication

**Fix**: Replace with public kpack images (Step 3 in this guide)
```bash
kubectl apply -f https://github.com/buildpacks-community/kpack/releases/download/v0.16.1/release-0.16.1.yaml
```

### Namespace Confusion

**Problem**: Resources not found where expected

**Key Points**:
- Korifi API pods: `korifi` namespace
- CF resources (orgs, spaces): `cf` and `system` namespaces  
- kpack: `kpack` namespace
- Organization `system` → Space `dev` in namespace `system`

### Service Account Token Issues

**Problem**: Service accounts show `0 secrets` in newer Kubernetes

**Solution**: Create tokens manually with duration:
```bash
kubectl create token SERVICE-ACCOUNT-NAME -n NAMESPACE --duration=1h
```

### API Returns Empty Results

**Problem**: API calls succeed but return empty lists (organizations, apps, etc.)

**Root Cause**: Service account lacks proper RBAC permissions to access CF resources

**Fix**: Grant cluster-admin permissions (Step 4 in this guide)
