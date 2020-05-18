//
//  Group.swift
//  Lesson1
//
//  Created by Vit K on 10.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation

struct GroupResponse: Decodable {
    var response: GroupList
}

struct GroupList: Decodable {
    var count: Int
    var items: [GroupItem]
}

struct GroupItem: Decodable {
//    var screen_name: String
    var photo50: String?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case photo50 = "photo_50"
        case name = "name"
    }
}
