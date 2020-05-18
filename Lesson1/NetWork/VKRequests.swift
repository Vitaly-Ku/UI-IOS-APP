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
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103"),
            URLQueryItem(name: "fields", value: "photo_100")
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
    static func groupsSearch(searchText: String, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103"),
            URLQueryItem(name: "q", value: searchText)
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
    static func loadPhotos(friendId: String, completion: @escaping (Result<PhotoResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.103"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: friendId)
        ]
        let request = URLRequest(url: urlComponents.url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let photo = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    completion(.success(photo))
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
