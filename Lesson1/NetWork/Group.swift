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
    @objc dynamic var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case photo50 = "photo_50"
        case name
        case id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class GroupResponse: Decodable {
    var response: GroupList
}

class GroupList: Decodable {
    var count: Int
    var items: [Group]
}

func saveDataGroups(_ groups: [Group]) {
    do {
        let realm = try Realm()
        let oldValue = realm.objects(Group.self)
        realm.beginWrite()
        realm.delete(oldValue)
        realm.add(groups, update: .modified)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}
