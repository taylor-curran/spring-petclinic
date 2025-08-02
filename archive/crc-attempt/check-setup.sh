#!/bin/bash
# Check OpenShift setup status

echo "OpenShift Demo Setup Status Check"
echo "=================================="
echo ""

# Check CRC installation
echo "🔍 Checking CRC installation..."
if command -v crc &> /dev/null; then
    echo "✅ CRC installed: $(crc version | head -1)"
    
    # Check CRC status
    echo "🔍 Checking CRC status..."
    CRC_STATUS=$(crc status 2>/dev/null)
    if echo "$CRC_STATUS" | grep -q "Running"; then
        echo "✅ CRC is running"
        echo "$CRC_STATUS"
    else
        echo "⚠️  CRC is not running"
        echo "$CRC_STATUS"
        echo ""
        echo "To start CRC, run: ./start-crc.sh"
    fi
else
    echo "❌ CRC not found"
fi

echo ""

# Check oc CLI
echo "🔍 Checking OpenShift CLI..."
if command -v oc &> /dev/null; then
    echo "✅ oc CLI available"
    
    # Check if logged in
    if oc whoami &> /dev/null; then
        echo "✅ Logged in as: $(oc whoami)"
        echo "   Server: $(oc whoami --show-server)"
        echo "   Project: $(oc project -q)"
    else
        echo "⚠️  Not logged in to OpenShift"
        echo "   Run: oc login -u developer https://api.crc.testing:6443"
    fi
else
    echo "❌ oc CLI not found"
fi

echo ""

# Check Helm
echo "🔍 Checking Helm..."
if command -v helm &> /dev/null; then
    echo "✅ Helm installed: $(helm version --short)"
else
    echo "❌ Helm not found"
fi

echo ""

# Check pull secret
echo "🔍 Checking pull secret..."
PULL_SECRET="$HOME/.crc/pull-secret.txt"
if [ -f "$PULL_SECRET" ]; then
    echo "✅ Pull secret exists at: $PULL_SECRET"
else
    echo "⚠️  Pull secret not found"
    echo "   Download from: https://console.redhat.com/openshift/create/local"
    echo "   Save as: $PULL_SECRET"
fi

echo ""
echo "Summary:"
echo "--------"
if command -v crc &> /dev/null && command -v oc &> /dev/null && command -v helm &> /dev/null; then
    echo "✅ All tools installed"
    if [ -f "$PULL_SECRET" ]; then
        echo "🚀 Ready to start OpenShift demo!"
    else
        echo "⚠️  Need pull secret to start CRC"
    fi
else
    echo "❌ Some tools missing - check output above"
fi
