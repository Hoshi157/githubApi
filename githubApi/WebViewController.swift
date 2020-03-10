//
//  WebViewController.swift
//  githubApi
//
//  Created by 福山帆士 on 2020/03/10.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // userリポジトリのURL
    var linkUrl: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("linkUrl=\(self.linkUrl!)")
        openUrl(urlString: linkUrl!, webView: webView)

        // Do any additional setup after loading the view.
    }
    
    func openUrl(urlString: String, webView: WKWebView) {
        let url: URL = URL(string: urlString)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
