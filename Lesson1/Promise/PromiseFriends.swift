//
//  PromiseFriends.swift
//  Lesson1
//
//  Created by Vit K on 02.07.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Alamofire
import RealmSwift
import PromiseKit

class PromiseFriends {
    
    static func freandPromise () -> Promise<[Friend]> {
        
        let params: Parameters = [
            "fields" : "photo_100,sex",
        ]
        
        let request = AF.request("https://api.vk.com/method/" + "friends.get",  parameters: getBaseParameters(params))
        
        return Promise { resolver in
            request.responseData {
                response in
                switch response.result {
                case let .success(value): do {
                    do {
                        let friend =  try JSONDecoder().decode(FriendResponse.self, from: value).response.items
                        saveDataFriends(friend)
                    }
                    catch {
                        print(error)
                    }
                    }
                case let .failure(error): resolver.reject(error)
                }
            }
        }
    }
    
   
}

func saveDataFriends(_ friends: [Friend]) {
    do {
        let realm = try Realm()
        print(realm.configuration.fileURL)
        let oldValue = realm.objects(Friend.self)
        realm.beginWrite()
        realm.delete(oldValue)
        realm.add(friends, update: .modified)
        try realm.commitWrite()
        
    } catch {
        print(error)
    }
}

private func getBaseParameters(_ params : Parameters) -> Parameters {
    var parameters = params
    parameters["access_token"] = Session.shared.token
    parameters["v"] = "5.103"
    return parameters
}
