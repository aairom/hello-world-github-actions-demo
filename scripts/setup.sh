#!/bin/bash

# Setup script for Hello World GitHub Actions Demo
# This script helps you get started quickly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print banner
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║     Hello World GitHub Actions Demo - Setup           ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if Node.js is installed
print_info "Checking Node.js installation..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    print_success "Node.js is installed: $NODE_VERSION"
    
    # Check if version is 18 or higher
    MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$MAJOR_VERSION" -lt 18 ]; then
        print_warning "Node.js version 18 or higher is recommended"
        print_info "Current version: $NODE_VERSION"
    fi
else
    print_error "Node.js is not installed"
    print_info "Please install Node.js 18 or higher from https://nodejs.org/"
    exit 1
fi

# Check if npm is installed
print_info "Checking npm installation..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    print_success "npm is installed: v$NPM_VERSION"
else
    print_error "npm is not installed"
    exit 1
fi

# Check if git is installed
print_info "Checking Git installation..."
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    print_success "Git is installed: $GIT_VERSION"
else
    print_warning "Git is not installed (optional but recommended)"
fi

# Create necessary directories
print_info "Creating project directories..."
mkdir -p input
mkdir -p output
mkdir -p scripts
print_success "Directories created"

# Check if package.json exists
if [ -f "package.json" ]; then
    print_info "Installing dependencies..."
    npm install
    print_success "Dependencies installed"
else
    print_warning "package.json not found, skipping dependency installation"
fi

# Make scripts executable
print_info "Setting script permissions..."
chmod +x scripts/*.sh 2>/dev/null || true
print_success "Script permissions set"

# Run tests
print_info "Running tests to verify installation..."
if npm test; then
    print_success "All tests passed!"
else
    print_warning "Some tests failed, but setup is complete"
fi

# Print next steps
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                        ║${NC}"
echo -e "${GREEN}║              Setup Complete! 🎉                        ║${NC}"
echo -e "${GREEN}║                                                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Start the application:"
echo -e "   ${YELLOW}npm start${NC}"
echo ""
echo "2. Open your browser:"
echo -e "   ${YELLOW}http://localhost:3000${NC}"
echo ""
echo "3. View the API:"
echo -e "   ${YELLOW}http://localhost:3000/api/hello${NC}"
echo ""
echo "4. Check health:"
echo -e "   ${YELLOW}http://localhost:3000/health${NC}"
echo ""
echo "5. Push to GitHub to trigger CI/CD:"
echo -e "   ${YELLOW}git add .${NC}"
echo -e "   ${YELLOW}git commit -m \"Initial commit\"${NC}"
echo -e "   ${YELLOW}git push origin main${NC}"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  📖 README.md - Project overview"
echo "  📖 Docs/UserGuide.md - User guide"
echo "  📖 Docs/Architecture.md - Architecture details"
echo "  📖 Docs/DeploymentGuide.md - Deployment instructions"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
echo ""

# Made with Bob
