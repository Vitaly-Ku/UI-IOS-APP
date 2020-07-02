////
////  ParseData.swift
////  Lesson1
////
////  Created by Vit K on 28.06.2020.
////  Copyright © 2020 Vitaly Kulagin. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//class ParseDataVKGroup: Operation {
//    
//    override func main() {
//        guard let getDataOperation = dependencies.first as? GetDataOperation,
//            let data = getDataOperation.data else { return }
//        
//        let dataVKGroups =  try? JSONDecoder().decode(FriendResponse.self, from: data).response.items
//        ParseDataVKGroup.self.saveDataFriends(dataVKGroups!)   
//    }
//    
//    static func saveDataFriends(_ friends: [Friend]) {
//        do {
//            let realm = try Realm()
//            print(realm.configuration.fileURL!)
//            let oldValue = realm.objects(Friend.self)
//            realm.beginWrite()
//            realm.delete(oldValue)
//            realm.add(friends, update: .modified)
//            try realm.commitWrite()
//            
//        } catch {
//            print(error)
//        }
//    }
//}
