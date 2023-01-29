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

## slim に変換

以下を追加

```
gem 'slim-rails'
gem 'html2slim'
```

`docker-compose exec web bundle` を実行しインストール

`docker-compose exec web bundle exec erb2slim app/views/layouts/ --delete`　を実行し slim に変換

## scss に変換

`docker-compose exec web rm app/assets/stylesheets/application.css`

`app/assets/stylesheets/application.scss` を作成

## bootstrap4 のインストール

以下を設定しインストール
taskleaf/package.json

```
{
  "name": "taskleaf",
  "private": true,
  "dependencies": {
    "@popperjs/core": "",
    "bootstrap": "^4.6.0",
    "jquery": "^3.4.1"
  }
}

```

taskleaf/app/assets/stylesheets/application.scss

```
@import "bootstrap/dist/css/bootstrap.min.css";

```

taskleaf/app/app/assets/javascripts/application.js

```
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery/dist/jquery.js
//= require popper.js/dist/popper.min.js
//= require_tree .
//= require bootstrap/dist/js/bootstrap.min.js
```

## 日本語の設定

config/locales/ja.yml を設定

```shell
curl -s https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -o taskleaf/config/locales/ja.yml
```

以下を追記
config/application.rb

```ruby

# module Taskleafの内部に記載

config.i18n.default_locale = :ja # 追加

```

## タスクモデル追加

```
docker-compose exec web bin/rails g model Task name:string description:text
```

```
docker-compose exec web bin/rails db:migrate
docker-compose exec web bin/rails c

#確認
Task.all
```

## タスクコントローラ

```
docker-compose exec web bin/rails g controller tasks index show new edit

```

route.rb をいかに変更

```
Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

resources は対象のリソースが複数の形であること前提である。
基本はこちらがよく使う。
resource は対象のリソースが単数の形であること前提である。
例で言えばユーザー自身のプロフィールのみをモデル化する場合、`resource :profile`となる。

## 新規登録画面


<% ～ %>　rubyを評価するが画面には表示しない
<%= ～ %>　rubyを評価し、画面に表示する

## 気をつける点

モデル名やキーワードでの単数形、複数形の指定
受け渡し変数が、インスタンス変数かローカル変数か、大文字小文字、単数複数などがずれてないか
きちんとルーティングどおりに遷移しているか？