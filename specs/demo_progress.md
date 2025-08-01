# CF to OpenShift Migration Demo Progress

## Demo Objective

Demonstrate automated migration of Java/Spring workloads from **Cloud Foundry** to **Red Hat OpenShift** using Windsurf AI-powered workflows that:

1. **Analyze** existing CF deployment manifests and service bindings
2. **Propose** OpenShift-native deployment strategies (Helm charts, operators, routes)
3. **Generate** compliant Kubernetes manifests following platform engineering standards
4. **Validate** generated resources against organizational policies and best practices

**Target Audience**: Platform engineering decision-makers evaluating automated migration tooling for TAS-to-OCP initiatives.

---

## File Organization Strategy

```
├── korifi-setup-files/
│   └── install-korifi-kind.yaml (existing - Korifi on Kind setup)
├── cf-korifi/ 
│   └── petclinic-app.json, CF API workflows (existing - working baseline)
├── cf-traditional/ 
│   └── manifest.yml, .cfignore, service bindings, buildpack configs
├── cf-traditional-setup-files/ 
│   └── TBD - Research if PCF Dev/cf-deployment can run locally
├── openshift-setup/ 
│   └── OKD/CRC installation, image registry, ingress configuration
└── openshift-deployment-migration-target/ 
    └── Helm charts, OpenShift templates, route definitions, RBAC
```

---

## Action Items

### Phase 1: Traditional CF Artifact Collection ⏳
- [ ] Research local PCF deployment options (PCF Dev, cf-deployment on BOSH-lite)
- [ ] **Decision Point**: Full PCF environment vs. configuration-only demonstration
- [ ] Create representative CF application manifest with service bindings
- [ ] Document typical CF service broker integrations (MySQL, Redis, etc.)
- [ ] Generate `.cfignore` and environment-specific variable files

### Phase 2: Korifi Baseline (✅ Complete)
- [x] Korifi v0.15.1 deployed on Kind with working CF API
- [x] Spring Petclinic successfully staged via CF buildpack workflow
- [x] Token-based authentication bypassing CF CLI OAuth limitations
- [x] Baseline deployment metrics captured

### Phase 3: OpenShift Target Environment 🔄
- [ ] Deploy OKD (Community OpenShift) on local Kind cluster
- [ ] Configure OpenShift image registry and router
- [ ] Set up Helm 3 and validate chart deployment workflows
- [ ] Establish OpenShift project (namespace) structure

### Phase 4: Migration Automation Logic 📋
- [ ] **Manifest Analysis**: Parse CF manifest.yml → extract app metadata, services, routes
- [ ] **Buildpack Translation**: Map CF buildpacks to OpenShift S2I builders or Dockerfile strategies  
- [ ] **Service Binding Migration**: CF VCAP_SERVICES → OpenShift Service Binding Operator
- [ ] **Helm Chart Generation**: Create OpenShift-native Deployment, Service, Route resources
- [ ] **Standards Validation**: Implement policy checks (resource limits, security contexts, labels)

### Phase 5: Demo Orchestration 🎬
- [ ] Record end-to-end migration workflow screencast
- [ ] Create "before/after" comparison metrics (deployment time, configuration complexity)
- [ ] Package demo as portable presentation for customer meetings
- [ ] Document troubleshooting scenarios and error handling

---

## Open Questions

### **Critical Path Decision**: Traditional CF Runtime
**Question**: Can we run traditional Pivotal Cloud Foundry locally without significant infrastructure investment?

**Options**:
- **PCF Dev** (deprecated but might work for demo purposes)  
- **cf-deployment** with BOSH-lite (complex setup, resource intensive)
- **Configuration-only** approach (realistic CF manifests without runtime)

**Recommendation Needed**: Research local PCF options before defaulting to config-only approach.

### **Research Validation**: Traditional CF Infrastructure Patterns
**Question**: What do real-world traditional CF infrastructure config files actually look like?

**Validation Areas**:
- **BOSH deployment manifests** - How are CF foundations typically configured?
- **Service broker integrations** - Standard patterns for MySQL, Redis, RabbitMQ bindings
- **Multi-environment configs** - How do teams handle dev/staging/prod variable injection?
- **Security policies** - What CF security groups, org/space quotas look like in practice
- **Buildpack configurations** - Custom buildpack definitions and offline scenarios

### Secondary Questions
- Should we demonstrate BOSH release migration to OpenShift Operators?
- How do we handle CF marketplace services → OpenShift Operator Hub mapping?
- Do we need multi-environment promotion workflows (dev → staging → prod)?

---

## Success Criteria

**Technical**: 
- Working CF → OpenShift migration pipeline for Spring Petclinic
- Generated Helm charts deploy successfully to OKD cluster
- Automated standards validation prevents policy violations

### Important Docs
CF vs TAS vs Korifi vs OpenShift

Cloud Foundry (CF) CLI commands (cf push, cf login, etc.) are identical whether you’re on open-source CF or VMware’s TAS distribution.

Tanzu Application Service (TAS) is simply the commercial distro of CF—same developer UX.

Korifi is how we “stand up” an open-source CF API on Kubernetes (via Kind), giving us a local TAS-like environment without licensing.

OpenShift is Red Hat’s enterprise Kubernetes, with its own CLI (oc), security defaults, and Operators—our target platform for the demo.