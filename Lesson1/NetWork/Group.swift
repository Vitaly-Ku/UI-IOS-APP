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
    var photo_50: String?
    var name: String
}



//{
//    count = 70;
//    items = (
//        {
//            id = 63963917;
//            "is_admin" = 0;
//            "is_advertiser" = 0;
//            "is_closed" = 0;
//            "is_member" = 1;
//            name = "\U043c\U0443\U0432\U0438\U0441.\U0436\U043f\U0433";
//            "photo_100" = "https://sun1-83.userapi.com/c824603/v824603774/13e6e5/8dNyhJgQmMs.jpg?ava=1";
//            "photo_200" = "https://sun1-86.userapi.com/c824603/v824603774/13e6e4/QTlBA1VgmH4.jpg?ava=1";
//            "photo_50" = "https://sun1-93.userapi.com/c824603/v824603774/13e6e6/Znlm4wqvog8.jpg?ava=1";
//            "screen_name" = "crazy_movie";
//            type = page;
//        }
//    );
//}
