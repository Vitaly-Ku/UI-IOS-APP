//
//  Group.swift
//  Lesson1
//
//  Created by Vit K on 10.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object, Decodable {
    @objc dynamic var photo50: String = ""
    @objc dynamic var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case photo50 = "photo_50"
        case name = "name"
    }
}

class GroupResponse: Decodable {
    var response: GroupList
}

class GroupList: Decodable {
    var count: Int
    var items: [Group]
}
