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
        
    @IBOutlet var webView: WKWebView! {
        didSet {
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
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                decisionHandler(.cancel)
                return
        }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        // MARK: ВЫЗОВ ЗАПРОСОВ
        
//        loadGroups()
//        loadFriends()
//        loadFotosFriends()
//        groupsSearch()
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
    }
    
    func loadGroups() {
        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103"]
        AF.request(VKServices.shared.baseUrl + VKServices.Method.getGroups.methodName, method: .get, parameters: param).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
    
    func loadFriends() {
        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "fields" : "photo_50"]
        AF.request(VKServices.shared.baseUrl + VKServices.Method.getFriends.methodName, method: .get, parameters: param).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func loadFotosFriends() {
        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "album_id" : "profile", "owner_id" : 76809617]
        AF.request(VKServices.shared.baseUrl + VKServices.Method.getPhotos.methodName, method: .get, parameters: param).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }

    func groupsSearch() {
        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "q" : "garage.band"]
        AF.request(VKServices.shared.baseUrl + VKServices.Method.searchGroups.methodName, method: .get, parameters: param).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
