//
//  Model.swift
//  githubApi
//
//  Created by 福山帆士 on 2020/03/05.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import Foundation

class Model {
    
    let url = "https://api.github.com/search/users"
    
    func fetchArticle() {
        guard var urlComponents = URLComponents(string: url) else {
            return
        }
        urlComponents.queryItems = [ URLQueryItem(name: "q", value: "Hoshi157") ]
        let task = URLSession.shared.dataTask(with: urlComponents.url!){ data, response, error in
            guard let jsonData = data else {
                return
            }
            print("jsonData:\(jsonData)")
            do {
                let articles = try JSONDecoder().decode(GithubStruct.self, from: jsonData)
                print("articles:\(articles)")
            } catch {
                print("Error:\(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
