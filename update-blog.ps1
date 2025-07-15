# Hexo 双仓库部署脚本 (修复版)
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

# === 第一步：部署静态页 ===
Write-Host "`n===== 部署静态页到 GitHub Pages =====" -ForegroundColor Cyan
hexo clean
hexo generate

# 进入 public 目录
Set-Location public
try {
    git init
    git add .
    git commit -m "自动更新静态页: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    
    # 关键修复：确保使用正确的 Pages 仓库
    git remote add pages $PagesRepo 2>$null
    git remote set-url pages $PagesRepo
    
    git branch -M main
    git push pages main --force
}
finally {
    Set-Location ..
}
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Green
Write-Host "访问地址: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# === 第二步：备份源文件 ===
Write-Host "`n===== 备份源文件到仓库 =====" -ForegroundColor Cyan

# 创建 .gitignore
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
"@ | Out-File -FilePath ".gitignore" -Encoding utf8 -Force

# 关键修复：区分源文件仓库
if (Test-Path ".git") {
    git remote set-url origin $BackupRepo
}
else {
    git init
    git remote add origin $BackupRepo
}

git add .
git commit -m "源文件备份: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" --allow-empty
git branch -M main
git push origin main --force

Write-Host "`n===== 操作完成 =====" -ForegroundColor Green
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Yellow
Write-Host "源文件已备份到: $BackupRepo" -ForegroundColor Yellow