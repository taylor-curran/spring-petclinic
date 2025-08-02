# File Organization - CF to OpenShift Migration Demo

## Current Structure (Post-Cleanup)

### 🏗️ Infrastructure Setup (Pre-Demo)
**Directory**: `openshift-setup/`
- **Purpose**: What the IT team has already set up
- **Not shown during demo** (assumed to be done)
- **Contents**: 
  - `openshift-setup.md` - Commands to prepare OpenShift cluster
  - ~~`pull-secret.txt`~~ - Removed (not needed for Kind demo)

### 🎯 Migration Target (Live Generation)
**Directory**: `migration-target/`
- **Purpose**: **EMPTY** directory ready for live generation during demo
- **This IS the demo focus** - showing live automation
- **Current State**: Only `README.md` (explains what will be generated)
- **Generated During Demo**:
  - `charts/petclinic/` - Complete Helm chart (auto-created by Cascade)

### 📋 Source Configurations  
**Directories**: `cf-korifi/`, `cf-traditional/`
- **Purpose**: Source CF configurations that drive the migration
- **Demo Input**: `cf-korifi/petclinic-app.json` (primary source)
- **Reference**: `cf-traditional/manifest.yml` (traditional format)

### 📚 Documentation & Specs
**Directory**: `specs/`
- **Purpose**: Demo documentation, progress tracking, workflow specs
- **Key Files**:
  - `demo_progress.md` - Current status and workflow phases
  - `demo_steps.md` - Step-by-step demo presentation guide
  - `setup_cf.md` - Korifi CF setup instructions

### 📦 Archive
**Directory**: `archive/`
- **Purpose**: Historical artifacts and pre-generated examples
- **Contents**:
  - `first-helm/` - Previously generated Helm charts (reference)
  - `crc-attempt/` - Archived CRC setup attempts

---

## Demo Workflow (Updated)

### **Phase 1-3: Core Workflow Development**
1. **"IT setup complete"** → `openshift-setup/` (pre-done)
2. **"Here's our CF app"** → `cf-korifi/petclinic-app.json` (source)
3. **"Cascade generates deployment"** → Live creation in `migration-target/`
4. **"Standards automatically applied"** → Policy compliance built-in
5. **"Deploy and verify"** → `helm install` → Running app

### **Phase 4-5: Future Expansion**
6. **"Devin applies standards"** → Cross-project policy enforcement
7. **"Multiple apps migrated"** → Portfolio-scale demonstration

## Key Philosophy

**Show the WORKFLOW, not the artifacts** - We demonstrate live automation, standards integration, and policy enforcement. The power is in the process, not pre-built files.
