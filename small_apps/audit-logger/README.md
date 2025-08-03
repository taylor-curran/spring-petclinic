# Audit Logger

## Artifact Design Thinking

**Platform**: Korifi  
**Complexity**: Low-Medium

### Design Rationale
This represents a compliance-focused logging service for banking audit trails. The artifacts demonstrate:

- **Go buildpack** for high-performance, low-memory footprint logging
- **Compliance-first design** with SOX, PCI, and GDPR compliance modes
- **Long-term retention** (7 years) meeting banking regulatory requirements
- **Encrypted storage** with S3 backend and encryption key management
- **Message queue integration** (NATS) for real-time audit event streaming
- **Korifi metadata** with compliance-level labeling

### Key Complexity Features
- Multi-compliance framework support (SOX, PCI, GDPR)
- Encrypted audit log storage with 7-year retention
- High-performance Go implementation for audit throughput
- NATS streaming for real-time audit event processing
- S3 integration for long-term regulatory storage

## Running and Testing

### Prerequisites
- Go 1.19 or higher
- Access to NATS server (for message streaming)
- S3-compatible storage (for audit log persistence)

### Build and Test
```bash
# Download dependencies
go mod download

# Build the application
go build -o audit-logger ./src

# Run tests (Note: currently no test files found)
go test ./...

# Run locally
./audit-logger

# Or run directly with go
go run ./src
```

### Configuration
- Update `service-config.yml` with your environment settings
- Configure NATS connection details
- Set S3 storage credentials and bucket information

### Korifi Deployment
```bash
# Deploy using the audit-app.json configuration
kf push audit-logger --config audit-app.json
```
