# Hexo ˫�ֿⲿ��ű� (�޸���)
# ����Ϊ deploy.ps1 �ڲ��͸�Ŀ¼

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

# ��һ��������̬ҳ
Write-Host "`n===== ����̬ҳ�� GitHub Pages =====" -ForegroundColor Cyan
hexo clean
hexo generate

# ���� public Ŀ¼����
Set-Location public

# ��ʼ�� Git �ֿ�
git init

# ��������ļ�
git add .

# �ύ����
git commit -m "�Զ����¾�̬ҳ: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# ���ӵ�Զ�ֿ̲�
git remote add origin $PagesRepo

# ǿ�����͵� main ��֧��ȷ����֧���ڣ�
git branch -M main  # ȷ����֧��Ϊ main
git push -u origin main --force

Set-Location ..
Write-Host "��̬ҳ�Ѳ���: $PagesRepo" -ForegroundColor Green
Write-Host "���ʵ�ַ: https://${GitHubUsername}.github.io" -ForegroundColor Cyan

# �ڶ���������Դ�ļ�
Write-Host "`n===== ����Դ�ļ����ֿ� =====" -ForegroundColor Cyan

# ��������� .gitignore
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

# ��ʼ���ֿ⣨�����δ��ʼ����
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $BackupRepo
}

# ��Ӳ��ύ�����ļ�
git add .
git commit -m "Դ�ļ�����: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# ȷ�����ط�֧��Ϊ main
git branch -M main

# ǿ�����͵����ݲֿ�
git push -u origin main --force

Write-Host "`n===== ������� =====" -ForegroundColor Green
Write-Host "��̬ҳ�Ѳ���: $PagesRepo" -ForegroundColor Yellow
Write-Host "Դ�ļ��ѱ��ݵ�: $BackupRepo" -ForegroundColor Yellow