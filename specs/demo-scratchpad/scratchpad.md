# CF → OpenShift Migration Plan

## Current State (CF-Korifi)
- App: `spring-petclinic` 
- Runtime: Buildpack (Paketo on Jammy stack)
- Space: `dev`

## Target State (OpenShift/Kind)
- ✅ Kind cluster ready (`korifi-control-plane`)
- ✅ NGINX Ingress installed
- ✅ Helm chart structure prepared in `charts/petclinic/`

## Migration Steps

# TODO:
What questions do we need to ask our selves

### 1. Create Migration Artifacts
- [ ] Generate Deployment manifest from CF app config
- [ ] Create Service manifest (port 8080)
- [ ] Setup Ingress for `petclinic.local`
- [ ] Configure health checks (`/actuator/health`)

### 2. Container Strategy  
- [ ] Use existing image: `docker.io/springcommunity/spring-petclinic:3.3.0`
- [ ] No buildpack conversion needed (pre-built container)

### 3. Deploy to OpenShift/Kind
- [ ] Apply Kubernetes manifests
- [ ] Verify pod startup and readiness
- [ ] Test ingress connectivity
- [ ] Validate health endpoints

### 4. Migration Demo Flow
1. **Show CF config** → CF app.json 
2. **Generate K8s manifests** → deployment.yaml, service.yaml, ingress.yaml
3. **Deploy to cluster** → `kubectl apply`
4. **Validate migration** → app accessible via ingress
5. **Standards check** → labels, resources, monitoring

## Key Differences
- **CF**: Buildpack-based, routes, spaces
- **OpenShift**: Container-based, ingress, namespaces
- **Same**: Spring Boot app, health checks, port 8080
