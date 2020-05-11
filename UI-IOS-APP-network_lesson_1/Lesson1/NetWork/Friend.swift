//
//  Friend.swift
//  Lesson1
//
//  Created by Vit K on 03.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation

struct Friend: Decodable {
    var items: [Item] = []
//    dynamic var first_name: String
//    dynamic var id = 0
//    dynamic var last_name: String
//    dynamic var photo = ""
//    dynamic var online = 0
}

//class VKResponse: Decodable {
//    let list: [Friend]
//}

struct Item: Decodable {
    var first_name: String?
    var last_name: String?
}










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
