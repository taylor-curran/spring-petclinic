# CF → OpenShift Migration Steps

## Goal: Auto-Generate Helm Chart from Korifi/CF Configuration

These steps will demonstrate how **Cascade can automatically convert** Cloud Foundry app configuration into OpenShift-ready Helm charts.

---

## Source Artifacts (Input)

### Primary Source: `cf-korifi/petclinic-app.json`
```json
{
  "name": "spring-petclinic",
  "lifecycle": { 
    "type": "buildpack", 
    "data": { "stack": "paketo-buildpacks-stacks-jammy" } 
  },
  "relationships": { 
    "space": { "data": { "guid": "dev" } } 
  }
}
```

### Additional Source: `cf-traditional/manifest.yml` (for reference)
```yaml
applications:
- name: spring-petclinic
  path: .
  memory: 512M
  instances: 1
  buildpack: java_buildpack
  env:
    SPRING_PROFILES_ACTIVE: cloud
  routes:
    - route: spring-petclinic.apps.example.io
```

---

## Migration Steps (For Cascade to Execute)

### Step 1: Analyze CF Configuration
**Input**: `cf-korifi/petclinic-app.json` + `cf-traditional/manifest.yml`
**Extract**:
- App name: `spring-petclinic`
- Memory limit: `512M` 
- Instances: `1`
- Buildpack: `java_buildpack` (Paketo)
- Environment: `SPRING_PROFILES_ACTIVE: cloud`
- Route: `spring-petclinic.apps.example.io`

### Step 2: Map CF Concepts → Kubernetes Concepts
| CF Concept | Kubernetes Equivalent | Value |
|------------|----------------------|-------|
| `memory: 512M` | `resources.limits.memory` | `512Mi` |
| `instances: 1` | `replicas` | `1` |
| `buildpack: java_buildpack` | `image` | `docker.io/springcommunity/spring-petclinic:3.3.0` |
| `routes` | `ingress.hosts` | `petclinic.local` |
| `env` | `env` variables | `SPRING_PROFILES_ACTIVE: cloud` |

### Step 3: Generate Helm Chart Structure
**Auto-create directories**:
```
migration-demo/charts/petclinic/
├── Chart.yaml
├── values.yaml
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── _helpers.tpl
```

### Step 4: Generate Chart.yaml
```yaml
apiVersion: v2
name: petclinic
description: Migrated Spring Boot Petclinic from Cloud Foundry
version: 1.0.0
appVersion: "3.3.0"
```

### Step 5: Generate values.yaml
**Map CF config to Helm values**:
```yaml
replicaCount: 1  # from CF instances

image:
  repository: docker.io/springcommunity/spring-petclinic
  tag: "3.3.0"  # from buildpack analysis
  pullPolicy: IfNotPresent

resources:
  limits:
    memory: 512Mi  # from CF memory
    cpu: 500m      # reasonable default
  requests:
    memory: 256Mi
    cpu: 250m

env:
  - name: SPRING_PROFILES_ACTIVE
    value: "cloud"  # from CF env

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: petclinic.local  # from CF route
      paths:
        - path: /
          pathType: Prefix

service:
  type: ClusterIP
  port: 8080  # Spring Boot default

# Spring Boot health checks
livenessProbe:
  httpGet:
    path: /actuator/health
    port: http
  initialDelaySeconds: 60
  periodSeconds: 30

readinessProbe:
  httpGet:
    path: /actuator/health/readiness
    port: http
  initialDelaySeconds: 30
  periodSeconds: 10
```

### Step 6: Generate Kubernetes Templates

#### `templates/deployment.yaml`
- Use CF app name for metadata
- Map CF memory → K8s resource limits
- Map CF instances → K8s replicas
- Add Spring Boot health checks (CF doesn't have equivalent)
- Apply enterprise standards (labels, security contexts)

#### `templates/service.yaml`
- Expose port 8080 (Spring Boot standard)
- Use CF app name for service name

#### `templates/ingress.yaml`
- Map CF route → K8s ingress host
- Use NGINX ingress class (OpenShift compatible)
- Add TLS termination (enhancement over CF)

### Step 7: Apply Enterprise Standards
**Add OpenShift/Enterprise requirements**:
- Resource limits (required)
- Proper labels (app, version, component)
- Security contexts (non-root user)
- Network policies (if required)
- Service accounts with minimal permissions

---

## Demo Execution Commands

### Pre-Demo: Clear Target Directory
```bash
# Remove existing generated files (keep README.md)
rm -rf migration-demo/charts/
rm -rf migration-demo/target-k8s-manifests/
rm -rf migration-demo/basic-k8s-manifests/
```

### During Demo: Generate Artifacts
```bash
# Cascade analyzes CF config and generates Helm chart
# INPUT: cf-korifi/petclinic-app.json + cf-traditional/manifest.yml
# OUTPUT: migration-demo/charts/petclinic/ (complete Helm chart)

# Deploy generated chart
helm install petclinic ./migration-demo/charts/petclinic

# Verify deployment
kubectl get pods,svc,ingress
```

---

## Success Criteria

- [x] Helm chart auto-generated from CF configuration
- [x] All K8s resources properly configured
- [x] Spring Boot health checks added
- [x] Resource limits applied from CF memory settings
- [x] Ingress configured from CF routes
- [x] Enterprise standards applied
- [x] App deploys successfully to OpenShift/K8s
- [x] Accessible via web browser

**Key Demo Point**: Show the **automation** - from CF config to running K8s app in minutes, not hours of manual YAML writing!
