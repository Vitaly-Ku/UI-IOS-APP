//
//  Friend.swift
//  Lesson1
//
//  Created by Vit K on 03.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FriendResponse: Decodable {
    var response: FriendList
}

struct FriendList: Decodable {
    var count: Int
    var items: [FriendItem]
}

struct FriendItem: Decodable {
    var first_name: String
    var last_name: String
    var online: Int
    var photo_50: String?
    var id: Int
}

//class User: Codable, CustomStringConvertible {
//    var description: String {
//    return "\(firstName) \(lastName)"
//    }
//
//    let firstName: String
//    let lastName: String
//    let online: Int
//    let photo50: String
//    let id: Int
//
//    init(json: JSON) {
//        self.firstName = json["first_name"].stringValue
//        self.lastName = json["last_name"].stringValue
//        self.online = json["online"].intValue
//        self.photo50 = json["photo_50"].stringValue
//        self.id = json["id"].intValue
//    }
//}









//{
//    count = 18;
//    items = (
//        {
//            "can_access_closed" = 1;
//            "first_name" = Alex;
//            id = 76809617;
//            "is_closed" = 0;
//            "last_name" = Jamma;
//            online = 0;
//            "photo_50" = "https://sun9-9.userapi.com/c853620/v853620819/a8759/KAvkyimUuPs.jpg?ava=1";
//            "track_code" = "5adf148c6P2TtWs2XEzOm22ouxFl7CxbKdNf-5rJa0er7KFotO6FlsCABmcLTZ3DWTgnxMWPTFY-yDqV";
//        }
//    );
//}

    

