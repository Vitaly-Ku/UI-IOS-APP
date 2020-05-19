//
//  Photo.swift
//  Lesson1
//
//  Created by Vit K on 11.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

struct PhotoResponse: Decodable {
    var response: PhotoList
}

struct PhotoList: Decodable {
//    var count: Int
    var items: [PhotoItems]
}

struct PhotoItems: Decodable {
//    var id: Int
    var sizes: [Photo]
}

class Photo: Object, Decodable {
//    var type = "m"
    @objc dynamic var url: String?
}
