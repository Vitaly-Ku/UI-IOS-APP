//
//  ReloadTableController.swift
//  Lesson1
//
//  Created by Vit K on 28.06.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import RealmSwift

class ReloadTableView: Operation {
    
    var controller: FriendsTableController
    var frriends: Results<Friend>?
    
    init(controller: FriendsTableController) {
        self.controller = controller
    }
    
    override func main() {
        guard (dependencies.first as? ParseFriends) != nil else { return }
        guard let realm = try? Realm() else {return}
        frriends = realm.objects(Friend.self)
        controller.friendResponse = frriends
        controller.tableView.reloadData()
  
  }
}
