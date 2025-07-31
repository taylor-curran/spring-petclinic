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

## Part 3: Windsurf-Guided Migration

### Windsurf Rules/Workflows Demo
- **[Windsurf-specific content - user will handle]**
- Show automated analysis of CF manifest
- Generate OpenShift resources with guided workflows
- Error prevention through rules engine
- Consistent, repeatable migration process

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
