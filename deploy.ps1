#!/usr/bin/env pwsh
# ========================================
# 🚀 一键部署到 GitHub Pages
# ========================================

$ErrorActionPreference = "Stop"
$env:PATH = "C:\Program Files\GitHub CLI;$env:PATH"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  🚀 每日AI头条 - 一键部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查 gh 是否已登录
$check = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "📌 需要先登录 GitHub" -ForegroundColor Yellow
    Write-Host "   正在打开浏览器进行 GitHub 授权..." -ForegroundColor Green
    gh auth login --web
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ 登录失败，请手动运行: gh auth login --web" -ForegroundColor Red
        exit 1
    }
}

# 2. 检查 gh 版本
$ver = gh --version
Write-Host "✅ GitHub CLI: $ver" -ForegroundColor Green

# 3. 获取 GitHub 用户名
$user = gh api user --jq .login
Write-Host "✅ 已登录: $user" -ForegroundColor Green

# 4. 创建仓库
$repoName = "ai-daily"
$repoExists = gh repo view "$user/$repoName" 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "📦 创建仓库 $repoName ..." -ForegroundColor Yellow
    gh repo create $repoName --public --description "每日AI头条 - 全网智能聚合" --push --source "$PSScriptRoot"
} else {
    Write-Host "📦 仓库已存在，推送更新..." -ForegroundColor Yellow
    Set-Location "$PSScriptRoot"
    gh repo deploy-keys 2>$null
    git init -b main 2>$null
    git remote add origin "https://github.com/$user/$repoName.git" 2>$null
    git add --all
    git commit -m "自动更新 $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>$null
    git push -u origin main --force
}

# 5. 开启 GitHub Pages
Write-Host "🌐 配置 GitHub Pages..." -ForegroundColor Yellow
gh api repos/$user/$repoName/pages -X POST -f source.branch=main 2>$null

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 部署完成！" -ForegroundColor Green  
Write-Host "  🌍 https://$user.github.io/$repoName/" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
