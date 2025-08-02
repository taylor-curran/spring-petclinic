#!/bin/bash
# Setup OpenShift demo project for Spring Petclinic migration

echo "Setting up OpenShift Demo Project"
echo "=================================="
echo ""

# Set up oc CLI environment
eval $(crc oc-env)

# Login check
if ! oc whoami &> /dev/null; then
    echo "❌ Not logged in to OpenShift. Please login first:"
    echo "   oc login -u developer https://api.crc.testing:6443"
    exit 1
fi

echo "✅ Logged in as: $(oc whoami)"
echo ""

# Create demo project
PROJECT_NAME="petclinic-migration-demo"
echo "🚀 Creating project: $PROJECT_NAME"
oc new-project $PROJECT_NAME --description="CF to OpenShift Migration Demo" || true

# Switch to project
oc project $PROJECT_NAME

echo ""
echo "🔧 Setting up project for Spring Boot deployments..."

# Label namespace for demo
oc label namespace $PROJECT_NAME demo=cf-migration --overwrite

# Create service account for demo
oc create serviceaccount petclinic-deployer || true

# Grant necessary permissions
oc policy add-role-to-user edit system:serviceaccount:$PROJECT_NAME:petclinic-deployer

echo ""
echo "✅ Demo project ready!"
echo ""
echo "Project: $PROJECT_NAME"
echo "Current project: $(oc project -q)"
echo ""
echo "Next steps:"
echo "1. Install Helm 3"
echo "2. Set up image registry access"
echo "3. Deploy test Spring Boot app"

# Show project info
echo ""
echo "Project Resources:"
oc get all
