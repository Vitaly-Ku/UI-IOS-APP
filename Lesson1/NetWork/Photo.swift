//
//  Photo.swift
//  Lesson1
//
//  Created by Vit K on 11.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object, Decodable {
    @objc dynamic var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

class PhotoResponse: Decodable {
    var response: PhotoList
}

class PhotoList: Decodable {
    var items: [PhotoItems]
}

class PhotoItems: Decodable {
    var sizes: [Photo]
}
