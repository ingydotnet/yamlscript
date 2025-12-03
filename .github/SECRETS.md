# GitHub Actions Secrets Setup

This document describes how to configure the secrets required for automated releases via GitHub Actions.

## Overview

The release workflow requires credentials for publishing to various package managers and services. These are stored as encrypted secrets in your GitHub repository.

## Required Secrets

### Core Secrets

- `GITHUB_TOKEN` - **Automatically provided by GitHub Actions** (no setup needed)

### Language Binding Package Managers

#### Clojure/Java
- `CLOJARS_USERNAME` - Your Clojars username
- `CLOJARS_PASSWORD` - Your Clojars password or deploy token

#### Rust
- `CRATES_IO_TOKEN` - API token from https://crates.io/settings/tokens

#### Python
- `PYPI_TOKEN` - API token from https://pypi.org/manage/account/token/

#### Ruby
- `RUBYGEMS_API_KEY` - API key from https://rubygems.org/profile/api_keys

#### Node.js
- `NPM_TOKEN` - Access token from https://www.npmjs.com/settings/~/tokens

#### .NET/C#
- `NUGET_API_KEY` - API key from https://www.nuget.org/account/apikeys

#### Haskell
- `HACKAGE_TOKEN` - API token from https://hackage.haskell.org/

#### Perl
- `CPAN_USERNAME` - Your PAUSE username
- `CPAN_PASSWORD` - Your PAUSE password

#### Crystal
- `CRYSTAL_TOKEN` - Token for Shardbox (if required)

#### Julia
- `JULIA_TOKEN` - Token for JuliaHub/package registry (if required)

#### Raku
- `RAKU_TOKEN` - Token for Raku Land/zef ecosystem (if required)

## How to Add Secrets

### Step 1: Navigate to Repository Settings

1. Go to your GitHub repository: https://github.com/yaml/yamlscript
2. Click **Settings** (top menu)
3. In the left sidebar, click **Secrets and variables** → **Actions**

### Step 2: Add Each Secret

1. Click **New repository secret**
2. Enter the **Name** (e.g., `PYPI_TOKEN`)
3. Enter the **Value** (the actual token/password)
4. Click **Add secret**

### Step 3: Verify Secrets

After adding all secrets, you should see them listed (values are hidden). The list should include:

- CLOJARS_USERNAME
- CLOJARS_PASSWORD
- CRATES_IO_TOKEN
- PYPI_TOKEN
- RUBYGEMS_API_KEY
- NPM_TOKEN
- NUGET_API_KEY
- HACKAGE_TOKEN
- CPAN_USERNAME
- CPAN_PASSWORD
- CRYSTAL_TOKEN (if needed)
- JULIA_TOKEN (if needed)
- RAKU_TOKEN (if needed)

## Obtaining Tokens

### Clojars (Clojure/Java)
1. Log in to https://clojars.org/
2. Go to your account settings
3. Generate a deploy token
4. Use your username and the deploy token

### Crates.io (Rust)
1. Log in to https://crates.io/
2. Go to https://crates.io/settings/tokens
3. Click **New Token**
4. Give it a name (e.g., "GitHub Actions")
5. Copy the token

### PyPI (Python)
1. Log in to https://pypi.org/
2. Go to https://pypi.org/manage/account/token/
3. Click **Add API token**
4. Name: "GitHub Actions"
5. Scope: "Entire account" or specific project
6. Copy the token (starts with `pypi-`)

### RubyGems (Ruby)
1. Log in to https://rubygems.org/
2. Go to https://rubygems.org/profile/api_keys
3. Click **New API Key**
4. Name: "GitHub Actions"
5. Copy the key

### npm (Node.js)
1. Log in to https://www.npmjs.com/
2. Click your profile icon → **Access Tokens**
3. Click **Generate New Token**
4. Choose **Automation** type
5. Copy the token

### NuGet (C#/.NET)
1. Log in to https://www.nuget.org/
2. Go to https://www.nuget.org/account/apikeys
3. Click **Create**
4. Set permissions and expiration
5. Copy the key

### Hackage (Haskell)
1. Log in to https://hackage.haskell.org/
2. Go to account settings
3. Generate an API token
4. Copy the token

### CPAN (Perl)
1. Use your PAUSE (Perl Authors Upload Server) credentials
2. Username: Your PAUSE ID
3. Password: Your PAUSE password
4. Get credentials at https://pause.perl.org/

## Migrating from Local Secrets

If you currently have secrets in `~/.yamlscript-secrets.yaml`, you'll need to:

1. Open your local secrets file:
   ```bash
   cat ~/.yamlscript-secrets.yaml
   ```

2. For each credential in that file, add it as a GitHub secret following the steps above

3. Map the local names to GitHub secret names:
   - `github-token` → `GITHUB_TOKEN` (automatic)
   - `clojars-username` → `CLOJARS_USERNAME`
   - `clojars-password` → `CLOJARS_PASSWORD`
   - etc.

## Security Best Practices

1. **Never commit secrets** to the repository
2. **Use tokens instead of passwords** when available
3. **Set expiration dates** on tokens when possible
4. **Limit scope** of tokens to only what's needed
5. **Rotate tokens periodically**
6. **Revoke compromised tokens immediately**

## Testing Secrets

After adding secrets, you can test the release workflow by:

1. Creating a test tag:
   ```bash
   git tag 0.0.0-test
   git push origin 0.0.0-test
   ```

2. Watch the workflow run in the **Actions** tab

3. Delete the test release and tag after verification

## Troubleshooting

### Secret not found
- Check spelling of secret name in workflow file
- Verify secret exists in repository settings
- Ensure secret name matches exactly (case-sensitive)

### Permission denied
- Verify the token/credential is valid
- Check that the token has required permissions/scopes
- Ensure the token hasn't expired

### Workflow can't access secret
- Secrets are only available to workflows in the same repository
- Fork PRs don't have access to secrets (security feature)
- Check that the workflow file references the secret correctly

## Additional Resources

- [GitHub Actions Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Package Manager Documentation Links](#obtaining-tokens)
