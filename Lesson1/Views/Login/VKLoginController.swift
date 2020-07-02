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
import Firebase

class VKLoginController: UIViewController {
        
    @IBOutlet private var webView: WKWebView!
    let vkRequest = VKRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(vkRequest.vkLoginRequest())
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
        print(Session.shared.token, " это токен")
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
        
        Database.database().reference(withPath: "пользователи").child(params["user_id"]!).setValue("\(Session.shared.userId)")
    }
}
