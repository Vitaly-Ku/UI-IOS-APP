//
//  FriendsCell.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import AlamofireImage

class FriendsTableCell: UITableViewCell {
        
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var shadov: UIView!
    
    @IBAction func avatarRotate() { 
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 350
        animation.duration = 0.7
        photo.layer.add(animation, forKey: nil)
    }
    
    func configureFriendsCell(friend: Friend) {
        titleLabel.text = friend.lastName + " " + friend.firstName
        statusLabel.text = friend.online == 0 ? "не в сети" : "в сети"
        statusLabel.textColor = friend.online == 0 ? .darkGray : .systemGreen
        let urlUserImage = friend.photo100
        photo.af.setImage(withURL: URL(string: urlUserImage)!)
    }
}
