# Contributing to Hello World GitHub Actions Demo

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [How to Contribute](#how-to-contribute)
4. [Development Workflow](#development-workflow)
5. [Coding Standards](#coding-standards)
6. [Testing Guidelines](#testing-guidelines)
7. [Pull Request Process](#pull-request-process)
8. [Reporting Issues](#reporting-issues)

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code:

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on what is best for the community
- Show empathy towards other community members

## Getting Started

### Prerequisites

- Node.js 18 or higher
- npm (comes with Node.js)
- Git
- A GitHub account

### Setup Development Environment

1. **Fork the repository** on GitHub

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/hello-world-github-actions-demo.git
   cd hello-world-github-actions-demo
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/ORIGINAL-OWNER/hello-world-github-actions-demo.git
   ```

4. **Run setup script**
   ```bash
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

5. **Verify installation**
   ```bash
   npm test
   npm start
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

- 🐛 **Bug fixes**
- ✨ **New features**
- 📝 **Documentation improvements**
- 🎨 **UI/UX enhancements**
- ⚡ **Performance improvements**
- ✅ **Test coverage**
- 🔧 **Configuration improvements**

### Finding Issues to Work On

- Check the [Issues](https://github.com/ORIGINAL-OWNER/hello-world-github-actions-demo/issues) page
- Look for issues labeled `good first issue` or `help wanted`
- Comment on the issue to let others know you're working on it

## Development Workflow

### 1. Create a Branch

```bash
# Update your local main branch
git checkout main
git pull upstream main

# Create a new branch
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### Branch Naming Convention

- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Test additions or modifications
- `chore/` - Maintenance tasks

### 2. Make Your Changes

- Write clean, readable code
- Follow existing code style
- Add comments for complex logic
- Update documentation as needed

### 3. Test Your Changes

```bash
# Run tests
npm test

# Test the application
npm start
```

### 4. Commit Your Changes

```bash
git add .
git commit -m "feat: add new feature description"
```

#### Commit Message Convention

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Test additions or modifications
- `chore:` - Maintenance tasks

Examples:
```
feat: add user authentication endpoint
fix: resolve memory leak in server shutdown
docs: update API documentation
test: add tests for health endpoint
```

### 5. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 6. Create a Pull Request

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill out the PR template
5. Submit the pull request

## Coding Standards

### JavaScript Style Guide

- Use ES6+ features
- Use `const` and `let`, avoid `var`
- Use arrow functions where appropriate
- Use template literals for string interpolation
- Add semicolons at the end of statements
- Use meaningful variable and function names

### Code Formatting

```javascript
// Good
const getUserData = async (userId) => {
  const response = await fetch(`/api/users/${userId}`);
  return response.json();
};

// Avoid
var getUserData = function(userId) {
  return fetch('/api/users/' + userId).then(function(response) {
    return response.json();
  });
};
```

### File Organization

```
src/
├── index.js          # Main application
├── test.js           # Test suite
└── utils/            # Utility functions (if needed)
```

### Documentation

- Add JSDoc comments for functions
- Update README.md for user-facing changes
- Update Architecture.md for architectural changes
- Add inline comments for complex logic

Example:
```javascript
/**
 * Creates an HTTP server and handles requests
 * @param {number} port - The port to listen on
 * @param {string} host - The host address
 * @returns {http.Server} The created server instance
 */
function createServer(port, host) {
  // Implementation
}
```

## Testing Guidelines

### Writing Tests

- Write tests for new features
- Ensure existing tests pass
- Aim for high test coverage
- Test edge cases and error conditions

### Test Structure

```javascript
// Test description
console.log('Test X: Description of what is being tested...');

// Perform test
const result = await performTest();

// Assert result
if (result === expected) {
  console.log('✅ PASS: Test description');
  testsPassed++;
} else {
  console.log('❌ FAIL: Test description');
  testsFailed++;
}
```

### Running Tests

```bash
# Run all tests
npm test

# Run specific test file
node src/test.js
```

## Pull Request Process

### Before Submitting

- [ ] Code follows the project's style guidelines
- [ ] All tests pass locally
- [ ] Documentation is updated
- [ ] Commit messages follow convention
- [ ] Branch is up to date with main

### PR Template

When creating a PR, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement

## Testing
Describe how you tested your changes

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] Code follows style guide
```

### Review Process

1. Automated checks will run (GitHub Actions)
2. Maintainers will review your code
3. Address any requested changes
4. Once approved, your PR will be merged

### After Your PR is Merged

1. Delete your branch
   ```bash
   git branch -d feature/your-feature-name
   git push origin --delete feature/your-feature-name
   ```

2. Update your local main
   ```bash
   git checkout main
   git pull upstream main
   ```

## Reporting Issues

### Bug Reports

When reporting bugs, include:

- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: OS, Node.js version, etc.
- **Screenshots**: If applicable

### Feature Requests

When requesting features, include:

- **Description**: Clear description of the feature
- **Use Case**: Why this feature is needed
- **Proposed Solution**: How you think it should work
- **Alternatives**: Other solutions you've considered

### Issue Template

```markdown
## Description
Clear description of the issue

## Steps to Reproduce (for bugs)
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., macOS 12.0]
- Node.js: [e.g., v18.0.0]
- npm: [e.g., v9.0.0]

## Additional Context
Any other relevant information
```

## Questions?

If you have questions:

1. Check existing [Issues](https://github.com/ORIGINAL-OWNER/hello-world-github-actions-demo/issues)
2. Check the [Documentation](README.md)
3. Open a new issue with the `question` label

## Recognition

Contributors will be recognized in:

- The project's README.md
- Release notes
- GitHub's contributor graph

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing! 🎉**

*Last Updated: 2026-05-07*