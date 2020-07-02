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
    @objc dynamic var id: Int = 0
    @objc dynamic var albumId: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var url: String = ""
    
    enum CodingKeysPhoto: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
    }
    
    enum CodingKeysPhotoSize: String, CodingKey {
        case type
        case url
    }
    
    convenience required init (from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeysPhoto.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.albumId = try values.decode(Int.self, forKey: .albumId)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        
        var photoSizeValues = try values.nestedUnkeyedContainer(forKey: .sizes)

        while !photoSizeValues.isAtEnd {
            let size = try photoSizeValues.nestedContainer(keyedBy: CodingKeysPhotoSize.self)
            let sizetype = try size.decode(String.self, forKey: .type)
            switch sizetype {
            case "x":
                self.url = try size.decode(String.self, forKey: .url)
            default:
                break
            }
        }
    }
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

class PhotoList: Decodable {
    let items: [Photo]
    
    enum CodingKeysPhotoData: String, CodingKey {
        case items
    }
}

class PhotoResponse: Decodable {
    let response: PhotoList
}

func saveDataPhotos(_ photos: [Photo], userId: Int) {
    do {
        let realm = try Realm()
        let filter = "ownerId == " + String(userId)
        let oldValue = realm.objects(Photo.self).filter(filter)
        realm.beginWrite()
        realm.delete(oldValue)
        realm.add(photos, update: .modified)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}
