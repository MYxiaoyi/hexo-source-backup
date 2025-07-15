# Hexo 双仓库部署脚本 (修复版)
# 保存为 deploy.ps1 在博客根目录

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

# 第一步：部署静态页
Write-Host "`n===== 部署静态页到 GitHub Pages =====" -ForegroundColor Cyan
hexo clean
hexo generate

# 进入 public 目录处理
Set-Location public

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "自动更新静态页: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# 连接到远程仓库
git remote add origin $PagesRepo

# 强制推送到 main 分支（确保分支存在）
git branch -M main  # 确保分支名为 main
git push -u origin main --force

Set-Location ..
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Green
Write-Host "访问地址: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# 第二步：备份源文件
Write-Host "`n===== 备份源文件到仓库 =====" -ForegroundColor Cyan

# 创建或更新 .gitignore
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

# 初始化仓库（如果尚未初始化）
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $BackupRepo
}

# 添加并提交所有文件
git add .
git commit -m "源文件备份: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# 确保本地分支名为 main
git branch -M main

# 强制推送到备份仓库
git push -u origin main --force

Write-Host "`n===== 操作完成 =====" -ForegroundColor Green
Write-Host "静态页已部署到: $PagesRepo" -ForegroundColor Yellow
Write-Host "源文件已备份到: $BackupRepo" -ForegroundColor Yellow