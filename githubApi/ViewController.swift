//
//  ViewController.swift
//  githubApi
//
//  Created by 福山帆士 on 2020/03/05.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let model: ViewModel = ViewModel()
    // userのリスト(タプル配列)
    var githubStruct: [(login: String, type: String, avatar_url: String, html_url: String)] = []
    // 検索に対してのレスポンス数
    var totalCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubStruct.count
    }
    // セルの表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // tableViewにusername,typeを表示
        let name: String = githubStruct[indexPath.row].login
        let userType: String = githubStruct[indexPath.row].type
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = userType
        // imageをセルに表示する
            let imageUrl: URL = URL(string: self.githubStruct[indexPath.row].avatar_url)!
        if let imageData: Data = try? Data(contentsOf: imageUrl) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    // セルがタップされたときの挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "Segue", sender: githubStruct[indexPath.row].html_url)
    }
    // セグエ時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let webViewController: WebViewController = segue.destination as! WebViewController
            // userリポジトリのリンクを値渡しする
            webViewController.linkUrl = sender as? String
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    // 入力しリターンを押したら処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        // 配列を空にする
        self.githubStruct.removeAll()
        // searchTextに文字が入力されているときに処理する
        if textField.text != "" {
            model.fetchArticle(keyword: textField.text!, completion: { (GithubStruct) in
                print("GithubStruct=\(GithubStruct)")
                let items: [Items] = GithubStruct.items
                
                self.totalCount = GithubStruct.total_count
                // totalCountは検索結果の件数
                if self.totalCount == 0 {
                    self.alet(message: "検索結果が0件でした")
                }
                // Itemを取り出す
                for item in items {
                    let login: String = item.login
                    let type: String = item.type
                    let avatar_url: String = item.avatar_url
                    let html_url: String = item.html_url
                    
                    let gitTuple: (login: String, type: String, avatar_url: String, html_url: String) = (login, type, avatar_url, html_url)
                    self.githubStruct.append(gitTuple)
                    print("githubStruct=\(self.githubStruct)")
                }
                // tableViewを更新
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        } else {
            // tableViewを更新
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    // 検索結果が0のときにアラートを表示する
    func alet(message: String) {
        let aletController: UIAlertController = UIAlertController(title: "アラート", message: message, preferredStyle: .alert)
        let aletAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        aletController.addAction(aletAction)
        present(aletController, animated: true)
    }
}
