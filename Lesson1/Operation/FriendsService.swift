
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
        
        //создаем очередь
        let queue = OperationQueue()
        
        //задача на выполнение запроса
        let getDataOperation = GetDataOperation(request: request)
        queue.addOperation(getDataOperation)
        
        //задача на парсинг даных
        let parseDataVKGroup = ParseDataVKGroup()
        //добавляем зависимость
        parseDataVKGroup.addDependency(getDataOperation)
        queue.addOperation(parseDataVKGroup)
        
        //задание на обновление контроллера
        let realoadGroupController = ReloadTableController(controller: controller)
        
        //добавляем зависимость
        realoadGroupController.addDependency(parseDataVKGroup)
        
        //добавляем на глвную очередь
        OperationQueue.main.addOperation(realoadGroupController)
        
    }
}

private func getBaseParameters(_ params : Parameters) -> Parameters {
    var parameters = params
    parameters["access_token"] = Session.shared.token
    parameters["v"] = "5.103"
    return parameters
}
