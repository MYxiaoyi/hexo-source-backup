# Hexo 博客一键更新脚本
# 保存为 update-blog.ps1 在博客根目录

# 配置信息 - 请修改以下变量为您的信息
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

# 第二步：备份源文件
Write-Host "`n===== 开始备份源文件 =====" -ForegroundColor Cyan

# 初始化备份仓库（如果尚未初始化）
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $BackupRepo
    git checkout -b main
}

# 创建 .gitignore 文件
if (-not (Test-Path ".gitignore")) {
    @"
# Hexo 忽略文件
node_modules/
public/
.deploy*/
db.json
*.log
"@ | Out-File -FilePath ".gitignore" -Encoding utf8
}

# 提交并推送更改
git add .
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "自动备份: $timestamp"
git push -u origin main --force

Write-Host "`n===== 操作完成 =====" -ForegroundColor Green
Write-Host "博客已更新并部署" -ForegroundColor Yellow
Write-Host "源文件已备份到: $BackupRepo" -ForegroundColor Yellow