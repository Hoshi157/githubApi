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
    let model: Model = Model()
    // userのリスト(タプル配列)
    var githubStruct: [(login: String, type: String, avatar_url: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        searchTextField.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    
    // 入力しリターンを押したら処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        // searchTextに文字が入力されているときに処理する
        if textField.text != "" {
            model.fetchArticle(keyword: textField.text!, completion: { (GithubStruct) in
                let items: [Items] = GithubStruct.items
                // 配列を空にする
                self.githubStruct.removeAll()
                // Itemを取り出す
                for item in items {
                    let login: String = item.login
                    let type: String = item.type
                    let avatar_url: String = item.avatar_url
                    
                    let gitTuple = (login, type, avatar_url)
                    self.githubStruct.append(gitTuple)
                    print("githubStruct=\(self.githubStruct)")
                }
                // tableViewを更新
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        return true
    }
}
