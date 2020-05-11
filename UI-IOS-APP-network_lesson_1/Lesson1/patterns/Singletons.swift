//
//  Singletons.swift
//  Lesson1
//
//  Created by Vit K on 26.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    
    public static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
}

