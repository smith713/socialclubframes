param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername,

    [string]$RepoName = "socialclubframes",

    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"
$SiteUrl = "https://$GitHubUsername.github.io/$RepoName/"

Write-Host ""
Write-Host "SocialClubFrames GitHub Pages Deployment" -ForegroundColor Magenta
Write-Host "Site URL will be: $SiteUrl" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git is not installed or is not available in PATH. Install Git for Windows, reopen PowerShell, and run this script again."
}

# Update deployment-specific SEO URLs.
$indexPath = Join-Path $PSScriptRoot "index.html"
$index = Get-Content $indexPath -Raw
$index = $index -replace "__SITE_URL__", $SiteUrl
Set-Content -Path $indexPath -Value $index -Encoding UTF8

$robotsPath = Join-Path $PSScriptRoot "robots.txt"
$robots = Get-Content $robotsPath -Raw
$robots = $robots -replace "__SITE_URL__", $SiteUrl
Set-Content -Path $robotsPath -Value $robots -Encoding UTF8

$sitemapPath = Join-Path $PSScriptRoot "sitemap.xml"
$sitemap = Get-Content $sitemapPath -Raw
$sitemap = $sitemap -replace "__SITE_URL__", $SiteUrl
Set-Content -Path $sitemapPath -Value $sitemap -Encoding UTF8

Set-Location $PSScriptRoot

if (-not (Test-Path ".git")) {
    git init
}

git branch -M $Branch
git add .
git commit -m "Deploy SocialClubFrames website" 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "No new commit was created. This is okay if the files were already committed." -ForegroundColor Yellow
}

$remoteUrl = "https://github.com/$GitHubUsername/$RepoName.git"
$existingOrigin = git remote get-url origin 2>$null

if ($LASTEXITCODE -eq 0 -and $existingOrigin) {
    git remote set-url origin $remoteUrl
} else {
    git remote add origin $remoteUrl
}

Write-Host ""
Write-Host "Pushing to $remoteUrl ..." -ForegroundColor Cyan
git push -u origin $Branch

Write-Host ""
Write-Host "Push complete." -ForegroundColor Green
Write-Host "Next: GitHub > repository Settings > Pages > Build and deployment > Deploy from a branch > $Branch / (root)." -ForegroundColor Yellow
Write-Host "Your expected Pages URL: $SiteUrl" -ForegroundColor Green
