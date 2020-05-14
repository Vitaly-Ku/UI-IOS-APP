//
//  VKRequests.swift
//  Lesson1
//
//  Created by Vit K on 07.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import Alamofire

class VKRequests {
    
    static func vkLoginRequest() -> URLRequest {
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
        return request
    }
    
     static func loadGroups(completion: @escaping (Result<GroupResponse, Error>) -> Void ) {
        let urlString = VKServices.shared.baseUrl + VKServices.Method.getGroups.methodName + "?access_token=\(Session.shared.token)&extended=1&v=5.103"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let group = try JSONDecoder().decode(GroupResponse.self, from: data)
                    completion(.success(group))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    static func loadFriends(completion: @escaping (Result<FriendResponse, Error>) -> Void) {
        let urlString = VKServices.shared.baseUrl + VKServices.Method.getFriends.methodName + "?access_token=\(Session.shared.token)&extended=1&v=5.103&fields=photo_100"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let friend = try JSONDecoder().decode(FriendResponse.self, from: data)
                    completion(.success(friend))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
//    static func loadFotosFriends(completion: @escaping (Result<PhotoResponse, Error>) -> Void) {
//        let urlString = VKServices.shared.baseUrl + VKServices.Method.getPhotos.methodName + "?access_token=\(Session.shared.token)&extended=1&v=5.103&album_id=profile&owner_id=\()"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("some error")
//                    completion(.failure(error))
//                    return
//                }
//                guard let data = data else { return }
//                do {
//                    let friend = try JSONDecoder().decode(FriendResponse.self, from: data)
//                    completion(.success(friend))
//                } catch let jsonError {
//                    print("FAILED TO DECODE JSON", jsonError)
//                    completion(.failure(jsonError))
//                }
//            }
//        }.resume()
//    }
    
    static func loadFotosFriends() {
        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "album_id" : "profile", "owner_id" : 76809617]
        AF.request(VKServices.shared.baseUrl + VKServices.Method.getPhotos.methodName, method: .get, parameters: param).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
    
//    static func groupsSearch() {
//        let param: Parameters = ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "q" : "garage.band"]
//        AF.request(VKServices.shared.baseUrl + VKServices.Method.searchGroups.methodName, method: .get, parameters: param).responseJSON { response in
//            guard let value = response.value else { return }
//            print(value)
//        }
//    }
}
//8bb4ca5d4d942b6357c10febfe55362a1a2daa3b12ae261904eafec352fa3eeae5f0f732f52eb770dd3b0

