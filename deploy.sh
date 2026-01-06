#!/usr/bin/env bash
#
# Deploy script for Jekyll site to gh-pages branch
# This script builds the site and pushes it to the gh-pages branch

set -e

MAIN_BRANCH="master"
GH_PAGES_BRANCH="gh-pages"
BUILD_DIR="_site"

echo "🚀 Starting deployment process..."

# Check if we're on the main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$MAIN_BRANCH" ]; then
    echo "⚠️  Warning: You're on branch '$CURRENT_BRANCH', not '$MAIN_BRANCH'"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check for uncommitted changes
if [[ -n $(git status . -s) ]]; then
    echo "❌ Error: You have uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Build the site
echo "📦 Building Jekyll site..."
bundle exec jekyll build

# Check if build was successful
if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ Error: Build directory '$BUILD_DIR' not found. Build may have failed."
    exit 1
fi

# Save current branch
CURRENT_BRANCH=$(git branch --show-current)

# Switch to gh-pages branch (or create it)
echo "🔄 Switching to gh-pages branch..."
if git show-ref --verify --quiet refs/heads/$GH_PAGES_BRANCH; then
    git checkout $GH_PAGES_BRANCH
    git pull origin $GH_PAGES_BRANCH 2>/dev/null || true
else
    git checkout --orphan $GH_PAGES_BRANCH
    git rm -rf . 2>/dev/null || true
fi

# Copy build files to root
echo "📋 Copying build files..."
cp -r $BUILD_DIR/* .
cp -r $BUILD_DIR/.* . 2>/dev/null || true

# Remove build directory from gh-pages
rm -rf $BUILD_DIR

# Add all files
git add -A

# Commit
if [[ -n $(git status . -s) ]]; then
    echo "💾 Committing changes..."
    git commit -m "Deploy site: $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Push to gh-pages
    echo "🚀 Pushing to gh-pages branch..."
    git push origin $GH_PAGES_BRANCH
    
    echo "✅ Successfully deployed to gh-pages!"
else
    echo "ℹ️  No changes to deploy."
fi

# Switch back to main branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout $CURRENT_BRANCH

echo "✨ Deployment complete!"
echo ""
echo "Your site should be live at: https://yashYRS.github.io"
echo "(It may take a few minutes for GitHub Pages to update)"

