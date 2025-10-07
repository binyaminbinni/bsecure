# Branch Cleanup Guide

This repository includes automated tools to remove all branches except `main`.

## Quick Start

### Using GitHub Actions (Recommended)

1. Navigate to the repository on GitHub
2. Click on the **Actions** tab
3. Select **Cleanup Branches** workflow from the left sidebar
4. Click **Run workflow** button
5. Confirm by clicking the green **Run workflow** button

This will automatically delete all branches except `main`.

### Using Command Line

If you prefer to run the cleanup locally:

```bash
./scripts/cleanup-branches.sh
```

This will:
- List all branches to be deleted
- Ask for confirmation
- Delete each branch from the remote repository

## Branches to be Removed

The following branches will be deleted:
- `copilot/add-repo-descriptions-and-license`
- `copilot/remove-unused-branches`
- `copilot/update-readme-design-and-content`
- `copilot/update-readme-style-and-content`
- `repo-hardening-baseline`

Only `main` will remain.

## Prerequisites

For manual script execution:
- Git installed and configured
- Push permissions to the repository
- Authenticated with GitHub (via SSH or HTTPS)

For GitHub Actions:
- Repository write permissions
- Actions must be enabled for the repository

## More Information

See `scripts/README.md` for detailed documentation.
