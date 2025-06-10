#!/bin/bash

# Emacs Configuration Validation Script
# This script validates that the Emacs configuration can load without syntax errors

set -e

echo "🔍 Validating Emacs configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if lit.org exists
if [[ ! -f "lit.org" ]]; then
    print_status "$RED" "❌ Error: lit.org file not found!"
    exit 1
fi

print_status "$YELLOW" "📝 Tangling lit.org to generate init.el..."

# Tangle the org file to generate init.el
if ! emacs --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"$(pwd)/lit.org\"))" 2>/dev/null; then
    print_status "$RED" "❌ Error: Failed to tangle lit.org. Check for syntax errors in org blocks."
    exit 1
fi

print_status "$GREEN" "✅ Successfully tangled lit.org"

# Test loading the configuration
print_status "$YELLOW" "🧪 Testing Emacs configuration loading..."

# Create a temporary file to capture any errors
error_log=$(mktemp)

# Try to load the configuration
if emacs --batch --load init.el --eval "(message \"Configuration loaded successfully\")" 2>"$error_log"; then
    print_status "$GREEN" "✅ Emacs configuration loads successfully!"
    rm -f "$error_log"

    # Also validate that lit.el was generated correctly
    if [[ -f "lit.el" ]]; then
        print_status "$GREEN" "✅ lit.el generated successfully"
    else
        print_status "$YELLOW" "⚠️  Warning: lit.el not found, but configuration loaded"
    fi

    exit 0
else
    print_status "$RED" "❌ Error: Emacs configuration failed to load!"
    print_status "$RED" "Error details:"
    cat "$error_log"
    rm -f "$error_log"

    print_status "$YELLOW" "💡 Common issues to check:"
    print_status "$YELLOW" "  - Unbalanced parentheses in elisp blocks"
    print_status "$YELLOW" "  - Invalid package configurations"
    print_status "$YELLOW" "  - Undefined variables or functions"
    print_status "$YELLOW" "  - Missing use-package closing parentheses"

    exit 1
fi
