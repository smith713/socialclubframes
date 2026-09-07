# SocialClubFrames — GitHub Pages Deployment

This folder is ready to deploy as a static GitHub Pages site.

## SEO included

- SEO page title and meta description
- `Latoyya Smith` included as author/creator and in structured data
- Open Graph sharing metadata
- Twitter/X sharing metadata
- Schema.org WebSite + Organization + Person structured data
- robots.txt
- sitemap.xml
- favicon + Apple touch icon
- web app manifest
- semantic SEO intro copy
- `.nojekyll` for GitHub Pages
- responsive desktop/mobile hero images

## Before you deploy

You need:
1. A GitHub account
2. Git for Windows installed
3. A new EMPTY GitHub repository, recommended name: `socialclubframes`

Do not add a README, .gitignore, or license when creating the repository because this project already contains files.

## Deploy from PowerShell — easiest method

1. Extract this ZIP.
2. Open the extracted folder in File Explorer.
3. Click the address bar, type `powershell`, and press Enter.
4. Run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\deploy-github-pages.ps1 -GitHubUsername "YOUR_GITHUB_USERNAME"
```

If your repository has a different name:

```powershell
.\deploy-github-pages.ps1 -GitHubUsername "YOUR_GITHUB_USERNAME" -RepoName "YOUR_REPOSITORY_NAME"
```

The script automatically:
- sets your GitHub Pages canonical URL;
- updates Open Graph URLs;
- updates robots.txt;
- updates sitemap.xml;
- initializes Git;
- commits the website;
- adds the GitHub remote; and
- pushes the project to `main`.

## Turn on GitHub Pages

After the push:

1. Open the repository on GitHub.
2. Select **Settings**.
3. Select **Pages**.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Branch: **main**
6. Folder: **/(root)**
7. Click **Save**.

GitHub will publish the site at:

`https://YOUR_GITHUB_USERNAME.github.io/socialclubframes/`

It can take a short time after the first deployment for the URL to become available.

## Manual PowerShell commands

If you do not want to use the included script:

```powershell
cd "C:\path\to\SocialClubFrames"
git init
git branch -M main
git add .
git commit -m "Initial SocialClubFrames website"
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/socialclubframes.git
git push -u origin main
```

The included deployment script is preferred because it also prepares the GitHub Pages SEO URLs before pushing.

## Later updates

After editing the website:

```powershell
git add .
git commit -m "Update SocialClubFrames website"
git push
```

GitHub Pages will redeploy from the updated `main` branch.

## Important SEO note

The packaged files intentionally use `__SITE_URL__` placeholders. Run `deploy-github-pages.ps1` before your first push so those placeholders are replaced with the correct GitHub Pages URL.

If you later connect a custom domain, update the canonical URL, sitemap, robots.txt, and social metadata to use the custom domain instead of the GitHub Pages URL.
