//
//  Friend.swift
//  Lesson1
//
//  Created by Vit K on 03.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

struct FriendResponse: Decodable {
    var response: FriendList
}

struct FriendList: Decodable {
    var count: Int
    var items: [Friend]
}

class Friend: Object, Decodable {
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var online: Int
    @objc dynamic var photo100: String?
    @objc dynamic var id: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case online = "online"
        case photo100 = "photo_100"
        case id = "id"
    }

}


