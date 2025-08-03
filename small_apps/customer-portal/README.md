# Customer Portal

## Artifact Design Thinking

**Platform**: Traditional Cloud Foundry  
**Complexity**: Medium

### Design Rationale
This represents a customer-facing banking web application built with modern frontend technologies. The artifacts demonstrate:

- **Node.js buildpack** for React-based single page application
- **Frontend-specific configurations** (CSP policies, analytics integration)
- **OAuth2 authentication** with proper redirect handling for banking security
- **Multiple domain routing** (portal.banking.com, mobile.banking.com)
- **Content delivery network** integration for performance
- **Feature flag management** for gradual feature rollouts

### Key Complexity Features
- OAuth2 authentication flow with banking-grade security
- Content Security Policy for XSS protection
- Multi-channel support (web + mobile domains)
- Analytics integration (Google Analytics, Hotjar)
- Session management with Redis
- Feature toggles for banking products (deposits, transfers)

## Running and Testing

### Prerequisites
- Node.js 16 or higher
- npm or yarn package manager
- Redis (for session management)

### Build and Test
```bash
# Install dependencies
npm install

# Run tests (Note: currently missing react-scripts dependency)
npm test

# Start development server
npm start

# Build for production
npm run build
```

### Configuration
- Update OAuth2 configuration in environment variables
- Configure Redis connection for session storage
- Set up analytics tracking IDs (Google Analytics, Hotjar)
- Configure feature flag endpoints

### Cloud Foundry Deployment
```bash
cf push
```

### Test Status
❌ **DEPENDENCY ISSUE** - Missing `react-scripts` dependency
💡 **FIX**: Run `npm install` to install missing dependencies
