# Transaction Processor

## Artifact Design Thinking

**Platform**: Traditional Cloud Foundry  
**Complexity**: High

### Design Rationale
This represents a high-throughput transaction processing engine for banking operations. The artifacts demonstrate:

- **High-performance configuration** with 5 instances and 2GB memory per instance
- **Database sharding** across 4 separate database instances for scalability
- **Kafka streaming** for real-time transaction processing with optimized consumer settings
- **JVM performance tuning** with G1 garbage collector and specific heap settings
- **Circuit breaker patterns** (Hystrix) for system resilience
- **Enterprise health checks** with extended timeout for complex processing

### Key Complexity Features
- Multi-shard database architecture for horizontal scaling
- High-throughput Kafka consumer configuration
- Circuit breaker and retry patterns
- Batch processing optimization (1000 record batches)
- Comprehensive service dependencies (audit, metrics, multiple DBs)

## Running and Testing

### Prerequisites
- Java 11 or higher
- Maven 3.6+
- Kafka (for transaction streaming)
- Multiple database instances (4 shards)
- Redis (for caching)

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

### Configuration
- Configure database shard connections in application.yml
- Set up Kafka consumer configuration for high throughput
- Configure circuit breaker thresholds
- Update batch processing parameters
- Set up monitoring and metrics endpoints

### Cloud Foundry Deployment
```bash
cf push
```

### Test Status
❌ **DEPENDENCY ISSUE** - Missing version for `spring-cloud-starter-netflix-hystrix` dependency in pom.xml
💡 **FIX**: Add version in dependency management section
