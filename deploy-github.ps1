# 🚀 每日AI头条 - 一键部署到 GitHub Pages
# 前提：需要先有一个 GitHub 账号
# 第一步：去 https://github.com/settings/tokens 创建 Personal Access Token
#         勾选 repo 权限，复制 token
# 第二步：运行这个脚本，输入 token 即可

$token = Read-Host "请输入你的 GitHub Personal Access Token (或直接回车跳过)"
if (-not $token) { Write-Host "跳过部署，使用本地服务模式"; exit }

$env:PATH = "C:\Program Files\GitHub CLI;$env:PATH"
$env:GH_TOKEN = $token

$user = gh api user --jq .login 2>$null
if (-not $user) { Write-Host "Token 无效"; exit 1 }
Write-Host "✅ 已登录: $user" -ForegroundColor Green

Set-Location "$PSScriptRoot"
git init -b main 2>$null
git add --all
git commit -m "自动部署 $(Get-Date -Format yyyy-MM-dd)" 2>$null

# 创建远程仓库并推送
$repoUrl = "https://github.com/$user/ai-daily.git"
gh repo create ai-daily --public --description "每日AI头条 - 全网智能聚合" 2>$null
git remote add origin $repoUrl 2>$null
git push -u origin main --force

# 开启 GitHub Pages
gh api repos/$user/ai-daily/pages -X POST -f source.branch=main 2>$null

$url = "https://$user.github.io/ai-daily/"
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 部署成功!" -ForegroundColor Green
Write-Host "  🌍 你的链接: $url" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green
Start-Process $url
