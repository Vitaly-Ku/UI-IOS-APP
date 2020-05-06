//
//  AlamofireServices.swift
//  Lesson1
//
//  Created by Vit K on 28.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import Alamofire

class VKServices {
    
    private init() {}
    
    public static let shared = VKServices()
    
    let baseUrl = "https://api.vk.com/method/"
//    var baseParameters: String {
//        return "access_token=\(Session.shared.token)&extended=1&v=5.103"
//    }
    
    enum Method {
        case getGroups
        case getFriends
        case getPhotos
        case searchGroups
        
        var methodName: String {
            switch self {
            case .getGroups:
                return "groups.get"
            case .getFriends:
                return "friends.get"
            case .getPhotos:
                return "photos.get"
            case .searchGroups:
                return "groups.search"
            }
        }
        
//        var parameters: String {
//            switch self {
//            case .getGroups:
//                return "extended=1&fields=name,photo_50"
//            case .getFriends:
//                return "fields=photo_50"
//            case .getPhotos:
//                return "photos.get"
//            case .searchGroups:
//                return "groups.search"
//            }
//        }
    }
}
