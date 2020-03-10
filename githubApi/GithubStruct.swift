//
//  GithubStruct.swift
//  githubApi
//
//  Created by 福山帆士 on 2020/03/06.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import Foundation

// Codableで振り分ける
struct GithubStruct: Codable {
    let items: [Items]
}
struct Items: Codable {
    let login: String
    let type: String
    let avatar_url: String
    let html_url: String
    }
