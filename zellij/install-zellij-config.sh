#!/bin/bash

# Install Zellij Configuration Script
# This script copies the Zellij config from nvim directory to the proper Zellij config location

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Script directory (where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source and destination paths
SOURCE_DIR="$SCRIPT_DIR"
DEST_DIR="$HOME/.config/zellij"
BACKUP_DIR="$HOME/.config/zellij-backup-$(date +%Y%m%d-%H%M%S)"

print_status "Installing Zellij configuration..."
print_status "Source: $SOURCE_DIR"
print_status "Destination: $DEST_DIR"

# Check if source directory exists and has the required files
if [[ ! -f "$SOURCE_DIR/config.kdl" ]]; then
    print_error "config.kdl not found in $SOURCE_DIR"
    exit 1
fi

if [[ ! -d "$SOURCE_DIR/layouts" ]] || [[ ! -f "$SOURCE_DIR/layouts/claude.kdl" ]]; then
    print_error "layouts/claude.kdl not found in $SOURCE_DIR"
    exit 1
fi

# Create backup if destination already exists
if [[ -d "$DEST_DIR" ]]; then
    print_warning "Existing Zellij config found at $DEST_DIR"
    print_status "Creating backup at $BACKUP_DIR"
    
    if ! cp -r "$DEST_DIR" "$BACKUP_DIR"; then
        print_error "Failed to create backup"
        exit 1
    fi
    
    print_success "Backup created successfully"
fi

# Create destination directory
print_status "Creating destination directory..."
mkdir -p "$DEST_DIR/layouts"

# Copy configuration files
print_status "Copying config.kdl..."
if cp "$SOURCE_DIR/config.kdl" "$DEST_DIR/config.kdl"; then
    print_success "config.kdl copied successfully"
else
    print_error "Failed to copy config.kdl"
    exit 1
fi

print_status "Copying layouts..."
if cp "$SOURCE_DIR/layouts/claude.kdl" "$DEST_DIR/layouts/claude.kdl"; then
    print_success "claude.kdl layout copied successfully"
else
    print_error "Failed to copy claude.kdl layout"
    exit 1
fi

# Set proper permissions
print_status "Setting proper permissions..."
chmod 644 "$DEST_DIR/config.kdl"
chmod 644 "$DEST_DIR/layouts/claude.kdl"
chmod 755 "$DEST_DIR"
chmod 755 "$DEST_DIR/layouts"

# Verify installation
print_status "Verifying installation..."
if [[ -f "$DEST_DIR/config.kdl" ]] && [[ -f "$DEST_DIR/layouts/claude.kdl" ]]; then
    print_success "Zellij configuration installed successfully!"
    echo
    print_status "Configuration files:"
    echo "  • $DEST_DIR/config.kdl"
    echo "  • $DEST_DIR/layouts/claude.kdl"
    echo
    if [[ -d "$BACKUP_DIR" ]]; then
        print_status "Previous configuration backed up to: $BACKUP_DIR"
    fi
    echo
    print_status "To use the new configuration:"
    echo "  • Restart any running Zellij sessions"
    echo "  • Run: zellij --layout claude"
    echo "  • Or just: zellij (for default layout)"
    echo
    print_success "Installation complete!"
else
    print_error "Installation verification failed"
    exit 1
fi