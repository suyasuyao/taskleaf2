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

以下追加
docker/db/Dockerfile

docker/web/databese.yml を追加し設定変更

docker/web/Dockerfile

.env 　を追加し、パスを確認

.ruby-version

```shell
# ビルド時のみ
docker-compose build --no-cache

# アプリケーション起動時毎回実施
docker-compose up

# データベースコンテナが存在しないときのみ
docker-compose exec web bin/rails db:create
# マイグレーションやデータ投入を行う際に
docker-compose exec web bin/rails db:migrate db:seed


#リセットしたいとき
docker container prune

#テストしたいとき
docker-compose  run --rm test bundle exec rspec spec/system/tasks_spec.rb

```


## slimに変換


以下を追加
```
gem 'slim-rails'
gem 'html2slim'
```

`docker-compose exec web bundle` を実行しインストール

`docker-compose exec web bundle exec erb2slim app/views/layouts/ --delete`　を実行しslimに変換

## scssに変換


`docker-compose exec web rm app/assets/stylesheets/application.css`

`app/assets/stylesheets/application.scss` を作成

```
@import "bootstrap";
```