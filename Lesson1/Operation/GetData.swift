//
//  GetData.swift
//  Lesson1
//
//  Created by Vit K on 28.06.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Alamofire

class GetOperationData : AsyncOperation {
    
    var request: DataRequest
    var data: Data?
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}
