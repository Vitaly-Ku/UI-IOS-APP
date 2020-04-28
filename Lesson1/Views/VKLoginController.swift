//
//  VKLoginController.swift
//  Lesson1
//
//  Created by Vit K on 28.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7437118"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
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
        print(params)
        
        guard let token = params["access_token"],
            let userId = Int(params["user_id"]!)
            else {
                decisionHandler(.cancel)
                return
        }
        
        self.token = token
        print(token, userId)
    }
    
    func loadGroups() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
//        let param:
        
    }
}

//[
//    "expires_in": "86400",
//    "access_token": "f6ae227206507600225942172bb246c20353a5ea92a307f2fa90429f004437726f6f426629362cfa3eb8b",
//    "user_id": "41136018"
//]
