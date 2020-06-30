//
//  ParseData.swift
//  Lesson1
//
//  Created by Vit K on 28.06.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

class ParseFriends: Operation {
    
    override func main() {
        guard let operation = dependencies.first as? GetOperationData,
            let data = operation.data else { return }
        
        let dataFriends =  try? JSONDecoder().decode(FriendResponse.self, from: data).response.items
        ParseFriends.self.saveDataFriends(dataFriends!)   
    }
    
    static func saveDataFriends(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL!)
            let oldValue = realm.objects(Friend.self)
            realm.beginWrite()
            realm.delete(oldValue)
            realm.add(friends, update: .modified)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
}
