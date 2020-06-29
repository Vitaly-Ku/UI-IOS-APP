//
//  VKRequests.swift
//  Lesson1
//
//  Created by Vit K on 07.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Alamofire

class VKRequests {
    
    // MARK: LOGIN REQUEST
    func vkLoginRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7437118"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    // MARK: GET GROUPS
    /// для примера оставил этот метод через URLSession
    func loadGroups(completion: @escaping () -> Void ) {
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
                    print("some error", error)
                    return
                }
                guard let data = data else { return }
                do {
                    let group = try JSONDecoder().decode(GroupResponse.self, from: data).response.items
                    saveDataGroups(group)
                    completion()
                } catch let jsonError {
                    print("FAILED TO DECODE JSON", jsonError)
                }
            }
        }.resume()
    }
    
    // MARK: GET FRIENDS
//    func getFriends() {
//        let params: Parameters = [
//            "fields" : "photo_100,sex", // sex = 1 or 2
//        ]
//        AF.request("https://api.vk.com/method/" + "friends.get",  parameters: getBaseParameters(params)).responseJSON { response in
//            guard let data = response.data else { return }
//            do {
//                let friend = try JSONDecoder().decode(FriendResponse.self, from: data).response.items
//                saveDataFriends(friend)
//            } catch  let jsonError {
//                print("FAILED TO DECODE JSON", jsonError)
//            }
//        }
//    }
    
    // MARK: GROUP SEARCH
    func groupsSearch(searchText: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        let params: Parameters = [
            "q" : searchText,
        ]
        AF.request("https://api.vk.com/method/" + "groups.search",  parameters: getBaseParameters(params)).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let group = try JSONDecoder().decode(GroupResponse.self, from: data).response.items
                completion(.success(group))
            } catch  let jsonError {
                print("FAILED TO DECODE JSON", jsonError)
            }
        }
    }
    
    // MARK: GET PHOTOS
    func loadPhotos(friendId: Int, completion: @escaping () -> Void) {
        let params: Parameters = [
            "album_id" : "profile",
            "owner_id" : friendId,
            "extended" : "1",
            
        ]
        AF.request("https://api.vk.com/method/" + "photos.get",  parameters: getBaseParameters(params)).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let photo = try JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                saveDataPhotos(photo, userId: friendId)
                completion()
                print(photo)
            } catch  let jsonError {
                print("FAILED TO DECODE JSON", jsonError)
            }
        }
    }
    
    // MARK: GET NEWS
    func getNewsfeed(completion: @escaping (_ array : NewsItems?) -> Void) {
        
        DispatchQueue.global().async { [weak self] in
            let params: Parameters = [
                "count" : 100,
                "filters" : "post",
            ]
            AF.request("https://api.vk.com/method/" + "newsfeed.get",
                       parameters: self!.getBaseParameters(params)).responseJSON{ response in
                        do {
                            guard let data = response.data else { return }
                            let res = try JSONDecoder().decode(ResponseNews.self, from: data)
                            completion(res.response)
                        } catch {
                            print("error: ", error)
                        }
            }
        }
    }
    
    // MARK: BASE PARAMETERS
    private func getBaseParameters(_ params : Parameters) -> Parameters {
        var parameters = params
        parameters["access_token"] = Session.shared.token
        parameters["v"] = "5.103"
        return parameters
    }
}
