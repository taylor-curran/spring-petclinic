# CF to OpenShift Migration Demo

**Audience**: Platform engineers and decision makers  
**Goal**: Show how Windsurf rules/workflows make CF→OpenShift migration straightforward and error-free

**Source**: OSS Cloud Foundry via Korifi on Kind (simulates TAS without licensing costs)  
**Target**: Red Hat OpenShift with containerized deployments  
**Example**: Spring Petclinic

## Part 1: Current State - CF/TAS Simulation

### Setup Verification
- Reference `setup_cf.md` for complete Korifi setup
- Verify Korifi cluster running (`kind get clusters`)
- Test API access (`curl -ks https://localhost/v3/info`)
- **Key Point**: This simulates TAS behavior without enterprise licensing

### Current CF Workflow
- Show existing `manifest.yml`
- Demo `cf push` workflow
- Highlight CF-specific concepts (buildpacks, services, routes)
- Show developer experience

## Part 2: Migration Challenges

### Common Pain Points
- Manifest→K8s resource translation
- Buildpack→Container image conversion  
- Service binding differences
- Networking/routing changes
- Developer workflow disruption
- **Key Point**: Manual migration is error-prone and inconsistent

## Part 3: Cascade-Powered Migration

### Live Generation Demo
**Source Artifacts**: 
- `cf-korifi/petclinic-app.json` (Korifi format)
- `cf-traditional/manifest.yml` (Traditional CF format)

**Migration Process**:
1. **Analyze CF Configuration**
   - Extract app name, memory, instances, buildpack, routes, env vars
   - Map CF concepts → Kubernetes equivalents

2. **Generate OpenShift Deployment** 
   - Cascade creates complete Helm chart in `migration-target/charts/petclinic/`
   - Auto-generates: Chart.yaml, values.yaml, templates/
   - Applies enterprise standards: resource limits, health checks, security

3. **Deploy to OpenShift**
   ```bash
   helm install petclinic ./migration-target/charts/petclinic
   kubectl get pods,svc,ingress
   ```

**Key Demo Points**:
- **Automation over manual work** - No YAML writing
- **CF knowledge → K8s deployment** - Bridge the gap  
- **Enterprise standards applied** - Resource limits, health checks
- **Minutes not hours** - Instant migration

## Part 4: OpenShift Deployment

### Container Strategy
- Multi-stage Dockerfile generation
- Image build and registry push
- Kubernetes deployment manifests

### GitOps/CI-CD Integration  
- Helm chart templating
- Jenkins pipeline setup
- Infrastructure as Code (Terraform)
- Automated deployment verification

## Part 5: Results & Benefits

### Before/After Comparison
- Manual vs guided migration time
- Error reduction
- Developer productivity
- Platform consistency

### Business Value
- Reduced migration risk
- Faster modernization timeline
- Lower operational overhead
- Improved developer experience

---

**Next Steps**: 
1. Set up OpenShift environment (CRC or cluster)
2. Develop specific Windsurf rules/workflows
3. Create detailed command sequences
