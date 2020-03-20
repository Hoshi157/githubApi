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

~~~
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
let imageUrl: URL = URL(string: self.githubStruct[indexPath.row].avatar_url)!(画像のURLを取得)  
  
   DispatchQueue.global().async {  
     let data = Data(contentsOf: imageUrl)
        DispatchQueue.main.async {  
          cell.imageView.image = UIImage(data: data)  
           tableView.reloaddata  
        }  
   }  
}
~~~

と上記の様なコードにしたところ、滑らかに動く様になったが  
①スクロールすると画像が変わってしまう  
②2回目以降の検索をかけた時に読み込めない  
などの問題が生じて今回は実装することができなかった。

## 解決策

~~~
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
let imageUrl: URL = URL(string: self.githubStruct[indexPath.row].avatar_url)!(画像のURLを取得)

        DispatchQueue.global().async {
            do {
                let imageData: Data = try Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: imageData)
                    // サブビュー再描画
                    cell.setNeedsLayout()
                }
            } catch {
                DispatchQueue.main.async {
                    cell.imageView?.image = #imageLiteral(resourceName: "noImage")
                }
            }
            }
         }
}

~~~
* メインキューでreloaddataではなくsetNeedLayoutしサブビューを再描画することで問題点①②を解決しtableViewが滑らかに動く様になった。
* 新たな問題点としてスクロールしセルが隠れるたびに画像が再度読み込まれるため画像がスクロールするたびに一度消えてしまう。(問題点③に設定)
