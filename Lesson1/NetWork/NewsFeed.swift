//
//  NewsFeed.swift
//  Lesson1
//
//  Created by Vit K on 25.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import Alamofire

class ResponseNews: Decodable {
    var response: NewsItems
    
    init(response: NewsItems) {
        self.response = response
    }
}

class NewsItems: Decodable {
    var items: [News]
    var profiles: [Friend]
    var groups: [Group]
    var nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
    
    init(items: [News], profiles: [Friend], groups: [Group], nextFrom: String) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
}


// MARK: - Item
class News: Decodable {
    var type: String = ""
    var sourceID = 0
    var date: Int = 0
    var postType = ""
    var text: String = ""
    var photos: PhotoList?
    var isFavorite: Bool = false
    var postID: Int = 0
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postID = try container.decode(Int.self, forKey: .postID)
        sourceID = try container.decode(Int.self, forKey: .sourceID)
        date = try container.decode(Int.self, forKey: .date)
        type = try container.decode(String.self, forKey: .type)
        if let postType = try container.decodeIfPresent(String.self, forKey: .postType) {
            self.postType = postType
        } else {
            self.postType = ""
        }
        if let text = try container.decodeIfPresent(String.self, forKey: .text) {
            self.text = text
        } else {
            self.text = ""
        }
        if let arr = try container.decodeIfPresent(PhotoList.self, forKey: .photos) {
            self.photos = arr
        } else {
            self.photos = nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
        case photos
        case comments
        case likesNews = "likes"
        case repostsNews = "reposts"
        case views
        case isFavorite = "is_favorite"
        case postID = "post_id"
    }
}
