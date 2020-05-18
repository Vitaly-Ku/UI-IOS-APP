//
//  VKLoginController.swift
//  Lesson1
//
//  Created by Vit K on 28.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKLoginController: UIViewController {
        
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(VKRequests.vkLoginRequest())
        webView.navigationDelegate = self
    }
}

extension VKLoginController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment
            else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"],
            let userId = Int(params["user_id"]!)
            else {
                decisionHandler(.allow)
                return
        }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        // MARK: ВЫЗОВ ЗАПРОСОВ
        
//        VKRequests.loadGroups()
//        VKRequests.loadFriends()
//        VKRequests.loadFotosFriends()
//        VKRequests.groupsSearch()
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
    }
}
