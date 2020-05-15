//
//  Photo.swift
//  Lesson1
//
//  Created by Vit K on 11.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation

struct PhotoResponse: Decodable {
    var response: PhotoList
}

struct PhotoList: Decodable {
    var count: Int
    var items: [PhotoItems]
}

struct PhotoItems: Decodable {
    var id: Int
    var sizes: [Sizes]
}

struct Sizes: Decodable {
//    var type: String
    var url: String?
}





//{                                                                                     <- PhotoResponse
//"response": {                                                                         <- PhotoList
//  "count": 39,
//  "items": [                                                                          <- items
//    {                                                                                 <- PhotoItems
//      "id": 215109917,
//      "album_id": -6,
//      "owner_id": 76809617,
//      "sizes": [                                                                      <- sizes
//        { 			                                                                <- Sizes
//          "type": "s",
//          "url": "https://sun9-40.userapi.com/c10512/u76809617/-6/s_7e7a40cb.jpg",
//          "width": 0,
//          "height": 0
//        },
//        {
//          "type": "m",
//          "url": "https://sun9-40.userapi.com/c10512/u76809617/-6/m_cd2566d9.jpg",
//          "width": 0,
//          "height": 0
//        },
//        {
//          "type": "x",
//          "url": "https://sun9-40.userapi.com/c10512/u76809617/-6/x_ee1a64ea.jpg",
//          "width": 0,
//          "height": 0
//        }
