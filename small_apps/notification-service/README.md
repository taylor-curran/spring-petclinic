# Notification Service

## Artifact Design Thinking

**Platform**: Korifi  
**Complexity**: Medium

### Design Rationale
This represents a multi-channel customer communication service for banking notifications. The artifacts demonstrate:

- **Node.js buildpack** for real-time notification processing and API integrations
- **Multi-provider strategy** (SendGrid, Twilio, Firebase) for email, SMS, and push notifications
- **Rate limiting configurations** preventing notification spam and managing costs
- **Template engine integration** (Handlebars) for personalized banking communications
- **Message queue processing** (RabbitMQ) for reliable notification delivery
- **Korifi metadata** focused on customer experience team ownership

### Key Complexity Features
- Multi-channel notification delivery (email, SMS, push)
- Integration with 3 different service providers for redundancy
- Rate limiting per channel to prevent abuse
- Template caching and personalization engine
- Queue-based reliable message delivery
- Banking-specific notification types (alerts, statements, promotions)

## Running and Testing

### Prerequisites
- Node.js 16 or higher
- npm or yarn package manager
- RabbitMQ (for message queue processing)
- API keys for notification providers (SendGrid, Twilio, Firebase)

### Build and Test
```bash
# Install dependencies
npm install

# Run tests (Note: currently missing jest dependency)
npm test

# Start development server
npm start

# Run in production mode
npm run start:prod
```

### Configuration
- Set up API keys for SendGrid, Twilio, and Firebase in environment variables
- Configure RabbitMQ connection details
- Update notification templates in the templates directory
- Configure rate limiting thresholds per channel

### Korifi Deployment
```bash
# Deploy to Korifi
kf push notification-service
```

### Test Status
❌ **DEPENDENCY ISSUE** - Missing `jest` dependency
💡 **FIX**: Run `npm install` to install missing dependencies
