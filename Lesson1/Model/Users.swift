//
//  File.swift
//  Lesson1
//
//  Created by Vit K on 30.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

struct Friends {
    var title: String
    var avatar: UIImage?
    var status: String
    var photoes: [UIImage?]
}

final class FriendsFactory {
    static func makeFriends() -> [Friends] {
        let alice = Friends(title: "Алиса", avatar: UIImage(named: "Алиса"), status: "жена", photoes:
            [UIImage(named: "a111"),
             UIImage(named: "a222"),
             UIImage(named: "a333"),
             UIImage(named: "a444"),
             UIImage(named: "a555")])

        let nessy = Friends(title: "Несси", avatar: UIImage(named: "Несси"), status: "кошка", photoes:
            [UIImage(named: "n111"),
             UIImage(named: "n222"),
             UIImage(named: "n333"),
             UIImage(named: "n444"),
             UIImage(named: "n555")])

        let rina = Friends(title: "Рина", avatar: UIImage(named: "Рина"), status: "кошка", photoes:
            [UIImage(named: "r111"),
             UIImage(named: "r222"),
             UIImage(named: "r333"),
             UIImage(named: "r444"),
             UIImage(named: "r555")])

        return [alice, nessy, rina]
    }
}
