first commit

# やること

- README 書く
  - 環境構築手順
    - rails
    - docker-compose)
- 環境構築する
  - rails
  - docker-compose
    - postgres

## バージョン

Ruby のバージョン(2.5.1)・
rails _5.2.6_ new taskleaf -d postgresql

## 構築時

### git 初期化

git init
git push -u origin main
rm -rf taskleaf/.git

gitignore 追加

```
# Ignore bundler config.
/.bundle

# Ignore bundler gems.
vendor/bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp

# Ignore other unneeded files.
doc/
*.swp
*~
.project
.DS_Store
.idea
.secret
```

## ruby 設定

## rails 作成

```
#作成
rails _5.2.6_ new taskleaf -d postgresql

cd taskleaf
# 動作確認 postgresは動かしてないのでエラーにはなるが
bin/rails s

git add -A

git commit -m "rails作成"
```

## Docker 環境構築
