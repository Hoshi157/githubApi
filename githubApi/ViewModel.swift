//
//  Model.swift
//  githubApi
//
//  Created by 福山帆士 on 2020/03/05.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import Foundation

class ViewModel {
    
    let url: String = "https://api.github.com/search/users"
    
    // リクエストメソッド
    func fetchArticle(keyword: String, completion: @escaping (GithubStruct) -> Void) {
        
        guard var urlComponents: URLComponents = URLComponents(string: url) else {
            return
        }
        // keywordを含む20件を取得
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: keyword),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "20")
        ]
        print("urlComponents==\(urlComponents)")
        
        // URLSessionでリクエストする
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: urlComponents.url!) { data, _, error in
            guard let jsonData = data else {
                return
            }
            do {
                let articles: GithubStruct = try JSONDecoder().decode(GithubStruct.self, from: jsonData)
                //　非同期処理完了ハンドラへ渡す
                completion(articles)
                print("articles:\(articles)")
            } catch {
                print("Error:\(error.localizedDescription)")
            }
        }
        // 通信開始
        task.resume()
    }
}