# githubApi
GitHubのapiを使用したuser検索アプリケーション

## ライブラリ
* SwiftLint

## ツール
* cocoaPods

## ノート
* アーキテクチャはMCVを意識して設計した。
* 非同期通信に対するテストコードを実装した。
* SwiftLintにて静的解析を行った。

## 問題点
* tableViewのスクロールが滑らかに動かないことから

'''swift:title  
DispatchQueue.global().async {  
let data = Data(contentsOf: url)
DispatchQueue.main.async {  
cell.imageView.image = UIImage(data: data)  
tableView.reloaddata  
}
'''

と上記の様なコードにしたところ、滑らかに動く様になったが①スクロールすると画像が変わってしまう②2回目以降の検索をかけた時に読み込めない、などの問題が  
生じて今回は実装することができなかった。


