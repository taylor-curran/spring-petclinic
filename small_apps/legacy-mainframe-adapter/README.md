# Legacy Mainframe Adapter

## Artifact Design Thinking

**Platform**: Traditional Cloud Foundry  
**Complexity**: Very High

### Design Rationale
This represents the most complex integration scenario - connecting modern banking APIs to legacy IBM mainframe systems. The artifacts demonstrate:

- **Multi-buildpack complexity** (Java + Binary) for IBM middleware libraries
- **Legacy protocol support** (CICS, IMS, DB2, IBM MQ, SNA/LU) typical in banking mainframes
- **Maximum resource allocation** (4GB memory, 8GB disk) for heavyweight IBM connectors
- **Legacy Java version** (Java 11) required for IBM CICS Transaction Gateway compatibility
- **Complex security integration** (RACF, SSL keystores, encryption algorithms)
- **Specialized health checks** with extended timeouts for mainframe response times

### Key Complexity Features
- IBM CICS transaction processing integration
- IMS database connectivity with PSB management  
- DB2 mainframe database with package/collection management
- IBM MQ message queuing with queue managers
- TN3270 terminal emulation and EBCDIC character encoding
- Circuit breaker patterns for unreliable legacy system connections
- COBOL copybook processing for data transformation

## Running and Testing

### Prerequisites
- Java 11 (required for IBM CICS Transaction Gateway compatibility)
- IBM middleware libraries (CICS TG, MQ Client, DB2 drivers)
- Access to mainframe systems (CICS, IMS, DB2, MQ)
- SSL certificates and keystores for mainframe authentication

### Build and Test
```bash
# Note: This adapter requires specialized IBM libraries not publicly available
# Contact IBM for CICS Transaction Gateway and related middleware

# Compile (requires IBM libraries in classpath)
javac -cp "lib/*" src/main/java/com/banking/mainframe/*.java

# Run tests (requires mainframe connectivity)
# No standard Maven/Gradle build due to proprietary IBM dependencies

# Run the adapter
java -cp "lib/*:target/classes" com.banking.mainframe.MainframeAdapter
```

### Configuration
- Configure CICS connection details in manifest.yml
- Set up DB2 database connections and package collections
- Configure IBM MQ queue manager connections
- Update SSL keystore paths and passwords
- Configure COBOL copybook locations

### Cloud Foundry Deployment
```bash
cf push
```

### Test Status
🔧 **SPECIALIZED SETUP** - Requires IBM mainframe middleware and connectivity
📋 **NO STANDARD BUILD** - Uses proprietary IBM libraries not in public repositories
