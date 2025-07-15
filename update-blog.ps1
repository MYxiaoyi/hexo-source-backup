# Hexo ˫�ֿⲿ��ű� (�޸���)
$GitHubUsername = "MYxiaoyi"
$PagesRepo = "https://github.com/$GitHubUsername/$GitHubUsername.github.io.git"
$BackupRepo = "https://github.com/$GitHubUsername/hexo-source-backup.git"

# ����Ҫ����
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "����: Git δ��װ���� PATH ��" -ForegroundColor Red
    exit 1
}
if (-not (Get-Command "hexo" -ErrorAction SilentlyContinue)) {
    Write-Host "����: Hexo δ��ȷ��װ" -ForegroundColor Red
    exit 1
}

# === ��һ��������̬ҳ ===
Write-Host "`n===== ����̬ҳ�� GitHub Pages =====" -ForegroundColor Cyan
hexo clean
hexo generate

# ���� public Ŀ¼
Set-Location public
try {
    git init
    git add .
    git commit -m "�Զ����¾�̬ҳ: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    
    # �ؼ��޸���ȷ��ʹ����ȷ�� Pages �ֿ�
    git remote add pages $PagesRepo 2>$null
    git remote set-url pages $PagesRepo
    
    git branch -M main
    git push pages main --force
}
finally {
    Set-Location ..
}
Write-Host "��̬ҳ�Ѳ���: $PagesRepo" -ForegroundColor Green
Write-Host "���ʵ�ַ: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# === �ڶ���������Դ�ļ� ===
Write-Host "`n===== ����Դ�ļ����ֿ� =====" -ForegroundColor Cyan

# ���� .gitignore
@"
# Hexo Դ�ļ����ݺ��Թ���
.DS_Store
Thumbs.db
*.log
*.tmp
node_modules/
public/
.deploy_git/
.cache/
"@ | Out-File -FilePath ".gitignore" -Encoding utf8 -Force

# �ؼ��޸�������Դ�ļ��ֿ�
if (Test-Path ".git") {
    git remote set-url origin $BackupRepo
}
else {
    git init
    git remote add origin $BackupRepo
}

git add .
git commit -m "Դ�ļ�����: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" --allow-empty
git branch -M main
git push origin main --force

Write-Host "`n===== ������� =====" -ForegroundColor Green
Write-Host "��̬ҳ�Ѳ���: $PagesRepo" -ForegroundColor Yellow
Write-Host "Դ�ļ��ѱ��ݵ�: $BackupRepo" -ForegroundColor Yellow