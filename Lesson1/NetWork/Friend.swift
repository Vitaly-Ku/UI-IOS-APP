//
//  Friend.swift
//  Lesson1
//
//  Created by Vit K on 03.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

class Friend: Object, Decodable {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var photo100: String = ""
    @objc dynamic var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case online = "online"
        case photo100 = "photo_100"
        case id = "id"
    }
}

class FriendResponse: Decodable {
    var response: FriendList
}

class FriendList: Decodable {
    var items: [Friend]
}


func loadDataFriends(_ friends: [Friend]) {

    do {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(friends)
        try realm.commitWrite()
        
    } catch {
        print(error)
    }
}


