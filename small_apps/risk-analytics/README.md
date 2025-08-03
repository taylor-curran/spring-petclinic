# Risk Analytics

## Artifact Design Thinking

**Platform**: Korifi  
**Complexity**: Medium-High

### Design Rationale
This represents a real-time risk analysis engine for banking portfolio management. The artifacts demonstrate:

- **.NET Core buildpack** showcasing enterprise Microsoft stack in cloud-native banking
- **Real-time streaming analytics** with Kafka integration for live transaction analysis
- **Time-series database** (InfluxDB) for financial metrics storage and analysis
- **Regulatory compliance** (Basel III, CCAR) with automated reporting capabilities
- **Machine learning integration** with external ML model services for risk prediction
- **Korifi metadata** emphasizing real-time model capabilities

### Key Complexity Features
- Real-time Value at Risk (VaR) calculations with 99% confidence intervals
- Kafka streaming for live transaction and market data processing
- Time-series data management with 30-day retention policies
- Basel III regulatory compliance automation
- Integration with external ML model services for risk prediction
- Multi-threshold alerting for credit, market, and operational risk
- Stress testing scenario analysis (baseline, adverse, severely adverse)

## Running and Testing

### Prerequisites
- .NET 6.0 SDK or higher
- Kafka (for streaming analytics)
- InfluxDB (for time-series data storage)
- Access to ML model services

### Build and Test
```bash
# Restore dependencies
dotnet restore

# Build the application
dotnet build

# Run tests (Note: .NET SDK not currently installed)
dotnet test

# Run the application
dotnet run

# Publish for deployment
dotnet publish -c Release
```

### Configuration
- Update `analytics-config.yml` with your environment settings
- Configure Kafka connection details for streaming data
- Set up InfluxDB connection for time-series storage
- Configure ML model service endpoints
- Update Basel III compliance parameters

### Korifi Deployment
```bash
# Deploy using the risk-app.json configuration
kf push risk-analytics --config risk-app.json
```

### Test Status
❌ **RUNTIME ISSUE** - .NET SDK not installed on system
💡 **FIX**: Install .NET 6.0 SDK or higher
