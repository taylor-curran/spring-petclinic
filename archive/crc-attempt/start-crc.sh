#!/bin/bash
# Start CRC - requires pull secret from https://console.redhat.com/openshift/create/local

echo "OpenShift CRC Startup Script"
echo "============================="
echo ""

# Check if pull secret exists
PULL_SECRET="$HOME/.crc/pull-secret.txt"

if [ ! -f "$PULL_SECRET" ]; then
    echo "❌ Pull secret not found at: $PULL_SECRET"
    echo ""
    echo "To get your pull secret:"
    echo "1. Go to: https://console.redhat.com/openshift/create/local"
    echo "2. Login with Red Hat account (free)"
    echo "3. Download pull-secret"
    echo "4. Save it as: $PULL_SECRET"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "✅ Pull secret found"
echo "🚀 Starting OpenShift CRC..."
echo ""

# Start CRC with increased resources for demo
crc start \
    --pull-secret-file "$PULL_SECRET" \
    --memory 12288 \
    --cpus 4 \
    --disk-size 50

echo ""
echo "✅ CRC Started!"
echo ""
echo "Getting credentials..."
crc console --credentials

echo ""
echo "Setting up oc CLI..."
eval $(crc oc-env)

echo ""
echo "OpenShift Console: $(crc console --url)"
echo ""
echo "To login to CLI:"
echo "  oc login -u developer https://api.crc.testing:6443"
echo "  # Use the password from above credentials output"
