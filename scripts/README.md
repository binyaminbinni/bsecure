# Branch Cleanup Scripts

This directory contains utilities for managing repository branches.

## cleanup-branches.sh

A script to delete all remote branches except `main`.

### Usage

**Prerequisites:**
- Git installed and configured
- Push access to the repository
- Authenticated with GitHub

**Run the script:**

```bash
./scripts/cleanup-branches.sh
```

The script will:
1. Fetch all remote branches
2. List all branches except `main`
3. Ask for confirmation before deletion
4. Delete each branch one by one

### Alternative: GitHub Actions Workflow

A GitHub Actions workflow is also available at `.github/workflows/cleanup-branches.yml`.

To use it:
1. Go to the repository on GitHub
2. Navigate to **Actions** tab
3. Select **Cleanup Branches** workflow
4. Click **Run workflow**
5. Confirm the execution

This will automatically delete all branches except `main`.

## Current Branches to Clean

Based on the latest check, the following branches exist and will be removed:
- `copilot/add-repo-descriptions-and-license`
- `copilot/remove-unused-branches`
- `copilot/update-readme-design-and-content`
- `copilot/update-readme-style-and-content`
- `repo-hardening-baseline`

Only `main` will remain after cleanup.
