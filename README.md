## config.tf.sample

```
$ cp config.tf.sample config.tf
```



## 1-1.webコンソールでアクセスキー、シークレットキーありのユーザを作成。

環境変数で設定
```
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
$ export AWS_DEFAULT_REGION=ap-northeast-1
```

## 1-2.アクセスキーとシークレットキーを.aws/credentialsに保存。pipでawscliをインストール

.aws/credentials

```
aws_access_key_id = 控えたアクセスキー
aws_secret_access_key = 控えたシークレットアクセスキー
```

```
$pip install awscli
```

## 1-3.Dockerの場合


```
$ docker build -t terraform:latest .
$ docker run --it terraform bash
```

```
(# source ~/.bash_profile)
# tfenv install <version>
# cd <tfファイルのあるディレクトリ>
# terraform init
```


## 2-1.IAMユーザのためのgpgキーを作成
https://qiita.com/reflet/items/dc109d1856b1ea525284


## 2-2.teraform.tfstateを作成、gpgを変数化


## 2-3.deployを行うためのユーザを作成

```
$cd admin_iam_user
($terraform init)
$terraform plan
$terraform init
```


## 2-4.アクセスキーと、暗号化されたシークレットキーがoutputされるので、コピペしファイルに保存、復号化

```
$ vim secret.gpg
先ほどコピペしたシークレットキーを貼り付ける
```

復号化
```
$ cat secret.gpg | base64 -D | gpg -r app-user
```

## 2-5 CircleCIのenvrionmentに設定
- AWS_ACCESS_KEY_ID: outputされたアクセスキー
- AWS_SECRET_ACCESS_KEY: outputされたシークレットキーを復号化したもの

### 別環境で秘密鍵をインポートし、復号化する

```
$ gpg --import app-user.private.gpg
```

