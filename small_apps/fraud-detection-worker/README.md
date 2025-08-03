# Fraud Detection Worker

## Artifact Design Thinking

**Platform**: Korifi  
**Complexity**: Medium-High

### Design Rationale
This represents a machine learning-powered background worker for real-time fraud detection. The artifacts demonstrate:

- **Python ML stack** with Paketo buildpacks for data science workloads
- **Message queue processing** (RabbitMQ) for async transaction analysis
- **ML model management** with versioned model artifacts and feature stores
- **Korifi metadata** with ML-specific labels (model version tracking)
- **Multi-database pattern** (Postgres for analytics, Redis for model cache)
- **Observability for ML** with model performance monitoring

### Key Complexity Features
- Machine learning model deployment and versioning
- Feature engineering pipeline integration
- Queue-based event processing
- Model caching and performance optimization
- Fraud analytics database with compliance requirements

## Running and Testing

### Prerequisites
- Python 3.8 or higher
- pip package manager
- RabbitMQ (for message queue processing)
- PostgreSQL (for analytics data)
- Redis (for model caching)

### Build and Test
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install test dependencies
pip install pytest pytest-cov

# Run tests (Note: currently missing pytest)
python -m pytest

# Run the worker
python src/fraud_worker.py
```

### Configuration
- Update `worker-config.yml` with your environment settings
- Configure RabbitMQ connection details
- Set PostgreSQL database connection
- Configure Redis for model caching
- Update ML model paths and versions

### Korifi Deployment
```bash
# Deploy using the fraud-worker-app.json configuration
kf push fraud-detection-worker --config fraud-worker-app.json
```

### Test Status
❌ **DEPENDENCY ISSUE** - Missing `pytest` module
💡 **FIX**: Run `pip install pytest` or install from requirements.txt
