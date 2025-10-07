#!/bin/bash

# Script to delete all branches except main
# This script should be run with appropriate GitHub permissions

echo "🔍 Fetching all remote branches..."
git fetch --all --prune

echo ""
echo "📋 Remote branches (excluding main):"
branches=$(git branch -r | grep -v '\->' | grep -v 'main$' | sed 's/origin\///' | tr -d ' ')

if [ -z "$branches" ]; then
    echo "✅ No branches to delete. Only 'main' exists."
    exit 0
fi

echo "$branches"
echo ""

# Count branches
count=$(echo "$branches" | wc -l)
echo "📊 Found $count branch(es) to delete"
echo ""

# Ask for confirmation
read -p "⚠️  Are you sure you want to delete these branches? (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "❌ Operation cancelled."
    exit 0
fi

echo ""
echo "🗑️  Deleting branches..."

# Delete each branch
while IFS= read -r branch; do
    if [ -n "$branch" ]; then
        echo "  Deleting: $branch"
        git push origin --delete "$branch" 2>&1
        if [ $? -eq 0 ]; then
            echo "  ✅ Deleted: $branch"
        else
            echo "  ❌ Failed to delete: $branch"
        fi
    fi
done <<< "$branches"

echo ""
echo "✨ Branch cleanup completed!"
