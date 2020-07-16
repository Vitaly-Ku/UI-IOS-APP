//
//  VKServiceProxy.swift
//  Lesson1
//
//  Created by Vit K on 05.07.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation

class VKServiceProxy: VKServiceInterface {
    let vkService: VKRequests
    init(vkService: VKRequests) {
        self.vkService = vkService
    }
    
//    func loadGroups(for user: Int, completion: (([Group]?, Error?) -> Void)?) {
//        self.vkService.loadGroups(for: user, completion: completion)
//        print("called func loadVKGroups with user=\(user)")
//    }
    
    func joinGroup(for group: Int) {
        self.vkService.joinGroup(for: group)
        print("called func joinGroup for group=\(group)")
    }
    
    func leaveGroup(for group: Int) {
        self.vkService.leaveGroup(for: group)
        print("called func leaveGroup for group=\(group)")
    }
}
