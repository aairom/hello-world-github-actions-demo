# Architecture Documentation

## System Overview

This document describes the architecture of the Hello World GitHub Actions Demo application, including the CI/CD pipeline, application structure, and deployment workflow.

## Application Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        Browser[Web Browser]
        API_Client[API Client]
    end
    
    subgraph "Application Layer"
        Server[Node.js HTTP Server]
        Router[Request Router]
        
        subgraph "Endpoints"
            Root["Root - Web UI"]
            Health["Health Check"]
            API["API - JSON"]
        end
    end
    
    Browser --> Server
    API_Client --> Server
    Server --> Router
    Router --> Root
    Router --> Health
    Router --> API
    
    style Server fill:#667eea
    style Router fill:#764ba2
    style Root fill:#48bb78
    style Health fill:#48bb78
    style API fill:#48bb78
```

## CI/CD Pipeline Architecture

```mermaid
graph LR
    subgraph "Source Control"
        Dev[Developer]
        Git[Git Repository]
    end
    
    subgraph "GitHub Actions"
        Trigger[Workflow Trigger]
        
        subgraph "Jobs"
            Test[Test Job]
            Lint[Lint Job]
            Security[Security Scan]
            Deploy[Deploy Job]
            Report[Generate Report]
        end
    end
    
    subgraph "Artifacts"
        BuildReport[Build Report]
        Logs[Action Logs]
    end
    
    Dev -->|Push/PR| Git
    Git -->|Webhook| Trigger
    Trigger --> Test
    Trigger --> Lint
    Trigger --> Security
    Test --> Deploy
    Lint --> Deploy
    Test --> Report
    Lint --> Report
    Security --> Report
    Report --> BuildReport
    Deploy --> Logs
    
    style Test fill:#48bb78
    style Lint fill:#4299e1
    style Security fill:#ed8936
    style Deploy fill:#9f7aea
    style Report fill:#38b2ac
```

## Workflow Execution Flow

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant Git as GitHub
    participant GHA as GitHub Actions
    participant Test as Test Runner
    participant Deploy as Deployment
    participant Artifact as Artifacts
    
    Dev->>Git: Push code to main/develop
    Git->>GHA: Trigger workflow
    
    par Parallel Execution
        GHA->>Test: Run tests
        GHA->>Test: Run lint checks
        GHA->>Test: Run security scan
    end
    
    Test-->>GHA: All checks passed
    
    alt Main branch
        GHA->>Deploy: Deploy application
        Deploy-->>GHA: Deployment successful
    end
    
    GHA->>Artifact: Generate build report
    Artifact-->>Dev: Upload artifacts
    
    GHA->>Dev: Notify completion
```

## Project Structure

```mermaid
graph TD
    Root[Project Root]
    
    Root --> SRC[src/]
    Root --> GHA[.github/workflows/]
    Root --> Docs[Docs/]
    Root --> Scripts[scripts/]
    Root --> Input[input/]
    Root --> Output[output/]
    Root --> Config[Configuration Files]
    
    SRC --> Index[index.js - Main App]
    SRC --> Test[test.js - Test Suite]
    
    GHA --> CICD[ci-cd.yml]
    
    Docs --> Arch[Architecture.md]
    Docs --> Guide[User Guide]
    
    Config --> Package[package.json]
    Config --> Ignore[.gitignore]
    Config --> README[README.md]
    
    style Root fill:#667eea
    style SRC fill:#48bb78
    style GHA fill:#ed8936
    style Docs fill:#4299e1
```

## Deployment Flow

```mermaid
flowchart TD
    Start([Code Push]) --> Check{Branch?}
    
    Check -->|main| MainFlow[Main Branch Flow]
    Check -->|develop| DevFlow[Develop Branch Flow]
    Check -->|feature| FeatureFlow[Feature Branch Flow]
    
    MainFlow --> Test1[Run Tests]
    DevFlow --> Test2[Run Tests]
    FeatureFlow --> Test3[Run Tests]
    
    Test1 --> Lint1[Code Quality]
    Test2 --> Lint2[Code Quality]
    Test3 --> Lint3[Code Quality]
    
    Lint1 --> Security1[Security Scan]
    Lint2 --> Security2[Security Scan]
    Lint3 --> Security3[Security Scan]
    
    Security1 --> Deploy[Deploy to Production]
    Security2 --> Report2[Generate Report]
    Security3 --> Report3[Generate Report]
    
    Deploy --> Report1[Generate Report]
    
    Report1 --> Success([Success])
    Report2 --> Success
    Report3 --> Success
    
    style Start fill:#48bb78
    style Deploy fill:#9f7aea
    style Success fill:#48bb78
```

## Component Interaction

```mermaid
graph TB
    subgraph "External"
        User[End User]
        GitHub[GitHub Platform]
    end
    
    subgraph "Application"
        App[Hello World App]
        Server[HTTP Server]
        Routes[Route Handlers]
    end
    
    subgraph "CI/CD"
        Actions[GitHub Actions]
        Workflows[Workflow Jobs]
        Artifacts[Build Artifacts]
    end
    
    User -->|HTTP Request| Server
    Server --> Routes
    Routes -->|Response| User
    
    GitHub -->|Webhook| Actions
    Actions --> Workflows
    Workflows -->|Test| App
    Workflows -->|Build| Artifacts
    
    style App fill:#667eea
    style Actions fill:#ed8936
    style User fill:#48bb78
```

## Technology Stack

```mermaid
mindmap
  root((Hello World<br/>Demo))
    Runtime
      Node.js 18+
      HTTP Module
    Development
      JavaScript
      Git
    CI/CD
      GitHub Actions
      Automated Testing
      Security Scanning
    Deployment
      Automated Pipeline
      Build Reports
      Artifact Storage
    Monitoring
      Health Checks
      API Endpoints
      Logging
```

## Key Features

### 1. **Application Features**
- Simple HTTP server with multiple endpoints
- Health check endpoint for monitoring
- JSON API for programmatic access
- Beautiful web UI with responsive design
- Graceful shutdown handling

### 2. **CI/CD Features**
- Automated testing on every push
- Code quality checks
- Security vulnerability scanning
- Automated deployment to main branch
- Build report generation
- Artifact retention

### 3. **GitHub Actions Integration**
- Multi-job parallel execution
- Conditional deployment
- Artifact upload and storage
- Comprehensive logging
- Status notifications

## Security Considerations

1. **Dependency Management**: Regular security audits via `npm audit`
2. **Access Control**: GitHub Actions uses repository secrets
3. **Branch Protection**: Main branch requires passing checks
4. **Artifact Retention**: Build reports stored for 30 days

## Scalability

The architecture is designed to be easily scalable:

- **Horizontal Scaling**: Multiple server instances can be deployed
- **CI/CD Pipeline**: Can be extended with additional jobs
- **Monitoring**: Health endpoints ready for integration with monitoring tools
- **Deployment**: Can be adapted for various hosting platforms

## Future Enhancements

1. Add Docker containerization
2. Implement database integration
3. Add authentication and authorization
4. Integrate with MCP Registry for server publishing
5. Add performance monitoring
6. Implement blue-green deployment strategy

---

**Last Updated**: 2026-05-07  
**Version**: 1.0.0