# OpenShift CRC (CodeReady Containers) Setup Guide

## Prerequisites

- macOS with Docker Desktop
- At least 9 GB RAM and 35 GB disk space available
- Red Hat account (free) for pull secret

## Installation Steps

### 1. Download CRC

```bash
# Download latest CRC for macOS
curl -L https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-macos-amd64.tar.xz -o crc-macos-amd64.tar.xz

# Extract
tar -xf crc-macos-amd64.tar.xz

# Move to PATH
sudo mv crc-macos-*/crc /usr/local/bin/
```

### 2. Setup CRC

```bash
# Setup (this configures the hypervisor)
crc setup

# Get pull secret from https://console.redhat.com/openshift/create/local
# Start CRC with pull secret
crc start --pull-secret-file /path/to/pull-secret.txt

# Get credentials
crc console --credentials
```

### 3. Verify Installation

```bash
# Check CRC status
crc status

# Login to OpenShift CLI
eval $(crc oc-env)
oc login -u developer https://api.crc.testing:6443
```

## Alternative: OKD (Community OpenShift)

If CRC requires too many resources, we can use OKD with Kind:

```bash
# Install OKD CLI
curl -L https://github.com/openshift/okd/releases/download/4.14.0-0.okd-2023-12-01-225814/openshift-client-mac.tar.gz -o oc.tar.gz
tar -xf oc.tar.gz
sudo mv oc /usr/local/bin/
```

## Expected Resources

- **CRC**: ~9GB RAM, 35GB disk
- **OKD on Kind**: ~4GB RAM, 20GB disk

## Next Steps

After successful installation:
1. Create demo project/namespace
2. Configure image registry access
3. Set up Helm 3
4. Deploy test Spring Boot application
