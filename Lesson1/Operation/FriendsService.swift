
//
//  FriendsService.swift
//  Lesson1
//
//  Created by Vit K on 29.06.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Alamofire

class FriendsService {
    
    static func getFriends(controller: FriendsTableController) {
        let params: Parameters = [
            "fields" : "photo_100,sex",
        ]
        let request = AF.request("https://api.vk.com/method/friends.get",  parameters: getBaseParameters(params))
        let queue = OperationQueue()
        let getData = GetOperationData(request: request)
        queue.addOperation(getData)
        let parse = ParseFriends()
        parse.addDependency(getData)
        queue.addOperation(parse)
        let reload = ReloadTableView(controller: controller)
        reload.addDependency(parse)
        OperationQueue.main.addOperation(reload)
    }
}

private func getBaseParameters(_ params : Parameters) -> Parameters {
    var parameters = params
    parameters["access_token"] = Session.shared.token
    parameters["v"] = "5.103"
    return parameters
}
