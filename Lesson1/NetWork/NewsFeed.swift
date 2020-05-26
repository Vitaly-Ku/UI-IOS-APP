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
    var attachments: [Attachment] = []
    var photos: PhotoList?
    var comments: Comments?
    var likesNews: LikesNews?
    var repostsNews: RepostsNews?
    var views: Views?
    var isFavorite: Bool = false
    var postID: Int = 0
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postID = try container.decode(Int.self, forKey: .postID)
        sourceID = try container.decode(Int.self, forKey: .sourceID)
        date = try container.decode(Int.self, forKey: .date)
        type = try container.decode(String.self, forKey: .type)
        if let arr = try container.decodeIfPresent(LikesNews.self, forKey: .likesNews) {
            self.likesNews = arr
        } else {
            self.likesNews = nil
        }
        if let arr = try container.decodeIfPresent(Comments.self, forKey: .comments) {
            self.comments = arr
        } else {
            self.comments = nil
        }
        if let arr = try container.decodeIfPresent(RepostsNews.self, forKey: .repostsNews) {
            self.repostsNews = arr
        } else {
            self.repostsNews = nil
        }
        if let arr = try container.decodeIfPresent(Views.self, forKey: .views) {
            self.views = arr
        } else {
            self.views = nil
        }
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
        if let arr = try container.decodeIfPresent(Array<Attachment>.self, forKey: .attachments) {
            self.attachments = arr
        } else {
            self.attachments = []
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
    
    func getLikesInfo() -> (Int,Bool) {
        guard let likes = likesNews else {
            return (0,false)
        }
        return (likes.count, likes.userLikes>0)
    }
    
    
    
    func getAuthorInfo() -> Group?{
        //        let params: Parameters = [
        //            "group_id": abs(self.sourceID)
        //        ]
        //        var group : Group? = nil
        //        DataService.getServerData(
        //            method: DataService.Methods.getGroupById,
        //            with: params,
        //            typeName: Group.self,
        //            completion: {
        //                array in
        //                group = (array as! [Group])[0]
        //            }
        //        )
        //        return group!
        return nil
    }
}

// MARK: - Attachment
class Attachment: Decodable {
    var type: String = ""
    var photo: Photo?
    var link: Link?
    var video: Video?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
        case link
        case video
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        if let arr = try container.decodeIfPresent(Photo.self, forKey: .photo) {
            self.photo = arr
        } else {
            self.photo = nil
        }
        if let arr = try container.decodeIfPresent(Link.self, forKey: .link) {
            self.link = arr
        } else {
            self.link = nil
        }
        if let arr = try container.decodeIfPresent(Video.self, forKey: .video) {
            self.video = arr
        } else {
            self.video = nil
        }
    }
    
}

// MARK: - Link
class Link: Decodable {
    var url: String = ""
    var title = ""
    var caption: String = ""
    var photo : Photo?
    
    enum CodingKeys: String, CodingKey {
        case url, title, caption, photo
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        if let caption = try container.decodeIfPresent(String.self, forKey: .caption) {
            self.caption = caption
        } else {
            self.caption = ""
        }
        if let arr = try container.decodeIfPresent(Photo.self, forKey: .photo) {
            self.photo = arr
        } else {
            self.photo = nil
        }
    }
}

// MARK: - Video
class Video: Decodable {
    var accessKey: String = ""
    var canComment = 0
    var canLike = 0
    var canRepost = 0
    var canSubscribe = 0
    var canAddToFaves = 0
    var canAdd = 0
    var comments = 0
    var date = 0
    var videoDescription: String = ""
    var duration: Int = 0
    var image: [FirstFrame] = []
    var firstFrame: [FirstFrame] = []
    var width = 0
    var height = 0
    var id = 0
    var ownerID = 0
    var title = ""
    var trackCode = ""
    var type: String = ""
    var views: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case trackCode = "track_code"
        case type, views
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
    }
}

// MARK: - FirstFrame
class FirstFrame: Decodable {
    var height: Int
    var url: String
    var width: Int
    var withPadding: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, url, width
        case withPadding = "with_padding"
    }
    
    init(height: Int, url: String, width: Int, withPadding: Int?) {
        self.height = height
        self.url = url
        self.width = width
        self.withPadding = withPadding
    }
}

// MARK: - Photo
//class PhotoNews: Decodable {
//    var id, albumID, ownerID, userID: Int
//    var sizes: [Size]
//    var text: String
//    var date: Int
//    var accessKey: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case userID = "user_id"
//        case sizes, text, date
//        case accessKey = "access_key"
//    }
//    
//    init(id: Int, albumID: Int, ownerID: Int, userID: Int, sizes: [Size], text: String, date: Int,  accessKey: String) {
//        self.id = id
//        self.albumID = albumID
//        self.ownerID = ownerID
//        self.userID = userID
//        self.sizes = sizes
//        self.text = text
//        self.date = date
//        self.accessKey = accessKey
//    }
//}


// MARK: - Comments
class Comments: Decodable {
    var count, canPost: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
    
    init(count: Int, canPost: Int) {
        self.count = count
        self.canPost = canPost
    }
}

// MARK: - LikesNews
class LikesNews: Decodable {
    var count, userLikes, canLike, canPublish: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
    
    init(count: Int, userLikes: Int, canLike: Int, canPublish: Int) {
        self.count = count
        self.userLikes = userLikes
        self.canLike = canLike
        self.canPublish = canPublish
    }
}

// MARK: - RepostsNews
class RepostsNews: Decodable {
    var count, userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
    
    init(count: Int, userReposted: Int) {
        self.count = count
        self.userReposted = userReposted
    }
}

// MARK: - Views
class Views: Decodable {
    var count: Int
    
    init(count: Int) {
        self.count = count
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Decodable {
    var visible: Bool
    var isOnline: Bool?
    var appID: Int?
    var isMobile: Bool?
    
    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case appID = "app_id"
        case isMobile = "is_mobile"
    }
    
    init(visible: Bool, isOnline: Bool?, appID: Int?, isMobile: Bool?) {
        self.visible = visible
        self.isOnline = isOnline
        self.appID = appID
        self.isMobile = isMobile
    }
}
