# Hexo 博客一键更新脚本
# 保存为 update-blog.ps1 在博客根目录
chcp 65001
$OutputEncoding = [System.Text.Encoding]::UTF8

# Hexo 博客一键更新脚本 (修复版)
# 保存为 update-blog.ps1 在博客根目录

# 配置信息
$GitHubUsername = "MYxiaoyi"
$BackupRepo = "https://github.com/$GitHubUsername/hexo-source-backup.git"

# 函数：检查命令是否存在
function Test-CommandExists {
    param($command)
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

# 检查必要命令
if (-not (Test-CommandExists "git")) {
    Write-Host "错误: Git 未安装或不在 PATH 中" -ForegroundColor Red
    exit 1
}

if (-not (Test-CommandExists "hexo")) {
    Write-Host "错误: Hexo 未正确安装" -ForegroundColor Red
    exit 1
}

# 第一步：更新博客内容
Write-Host "`n===== 开始更新博客 =====" -ForegroundColor Cyan
hexo clean
hexo generate
hexo deploy
Write-Host "博客已部署到 GitHub Pages" -ForegroundColor Green
Write-Host "访问地址: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# 第二步：备份源文件（修复版）
Write-Host "`n===== 开始备份源文件 =====" -ForegroundColor Cyan

# 创建专用备份目录
$backupDir = "hexo-backup-temp"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

# 仅复制必要的Hexo源文件
$essentialFiles = @(
    "_config.yml",
    "_config.butterfly.yml",  # 如果您使用Butterfly主题
    "scaffolds/",
    "source/",
    "themes/",
    "package.json",
    "package-lock.json"
)

foreach ($file in $essentialFiles) {
    if (Test-Path $file) {
        Copy-Item -Path $file -Destination "$backupDir/$file" -Recurse -Force
    }
}

# 进入备份目录
Set-Location $backupDir

# 初始化Git仓库
git init
git remote add origin $BackupRepo

# 创建针对Hexo的.gitignore
@"
# Hexo备份忽略文件
.DS_Store
Thumbs.db
*.log
*.tmp
node_modules/
public/
.deploy_git/
"@ | Out-File -FilePath ".gitignore" -Encoding utf8

# 添加并提交文件
git add .
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "自动备份: $timestamp"

# 强制推送到备份仓库
git push -u origin HEAD:main --force

# 返回原始目录并清理临时文件
Set-Location ..
Remove-Item $backupDir -Recurse -Force

Write-Host "`n===== 操作完成 =====" -ForegroundColor Green
Write-Host "博客已更新并部署" -ForegroundColor Yellow
Write-Host "源文件已备份到: $BackupRepo" -ForegroundColor Yellow