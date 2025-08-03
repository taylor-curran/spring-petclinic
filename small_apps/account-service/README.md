# Account Service

## Artifact Design Thinking

**Platform**: Traditional Cloud Foundry  
**Complexity**: High

### Design Rationale
This represents a core banking microservice with enterprise-grade complexity. The artifacts demonstrate:

- **Traditional CF manifest.yml** with comprehensive application configuration
- **High-availability setup** with 3 instances and proper resource allocation
- **Multiple service bindings** (databases, caches, service registry)
- **Enterprise integration patterns** (Eureka, circuit breakers, config server)
- **Multiple routes** for internal/external API access
- **Production JVM tuning** with specific garbage collection settings

### Key Complexity Features
- Multi-database architecture (primary + cache)
- Service mesh integration (Eureka service discovery)
- Circuit breaker pattern for resilience
- Comprehensive health checks
- Enterprise monitoring (New Relic, DataDog)

## Running and Testing

### Prerequisites
- Java 11 or higher
- Maven 3.6+

### Build and Test
```bash
# Install dependencies and compile
mvn clean compile

# Run tests (Note: currently has dependency version issue)
mvn test

# Build application
mvn clean package

# Run locally
mvn spring-boot:run
```

### Known Issues
- Missing version for `spring-cloud-starter-netflix-hystrix` dependency in pom.xml
- Fix by adding version in dependency management section

### Cloud Foundry Deployment
```bash
cf push
```
