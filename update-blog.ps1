# Hexo 双仓库部署脚本
# 保存为 deploy.ps1 在博客根目录
# 功能：1. 部署静态页到 MYxiaoyi.github.io  2. 备份源文件到 hexo-source-backup

# 配置信息 - 请修改以下变量
$GitHubUsername = "MYxiaoyi"
$PagesRepo = "https://github.com/$GitHubUsername/$GitHubUsername.github.io.git"
$BackupRepo = "https://github.com/$GitHubUsername/hexo-source-backup.git"

# 检查必要命令
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "错误: Git 未安装或不在 PATH 中" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command "hexo" -ErrorAction SilentlyContinue)) {
    Write-Host "错误: Hexo 未正确安装" -ForegroundColor Red
    exit 1
}

# 第一步：生成并部署静态页到 GitHub Pages
Write-Host "`n===== 部署静态页到 GitHub Pages =====" -ForegroundColor Cyan
hexo clean
hexo generate
Write-Host "生成的静态文件位置: public/" -ForegroundColor Yellow

# 部署到 GitHub Pages 仓库
Set-Location public
git init
git remote add origin $PagesRepo
git add .
git commit -m "自动更新静态页: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push -u origin main --force
Set-Location ..
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Green
Write-Host "访问地址: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# 第二步：备份源文件到备份仓库
Write-Host "`n===== 备份源文件到仓库 =====" -ForegroundColor Cyan

# 创建源文件备份的.gitignore
if (-not (Test-Path ".gitignore")) {
    @"
# Hexo 源文件备份忽略规则
.DS_Store
Thumbs.db
*.log
*.tmp
node_modules/
public/
.deploy_git/
.cache/
"@ | Out-File -FilePath ".gitignore" -Encoding utf8
}

# 初始化源文件仓库并推送
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $BackupRepo
    git checkout -b main
}

git add .
$backupMessage = "源文件备份: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $backupMessage
git push -u origin main --force

Write-Host "`n===== 操作完成 =====" -ForegroundColor Green
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Yellow
Write-Host "源文件已备份到: $BackupRepo" -ForegroundColor Yellow