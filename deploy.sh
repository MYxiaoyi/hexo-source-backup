#!/bin/bash
hexo clean
hexo generate
hexo deploy
git add .
git commit -m "更新博客内容"
git push origin main