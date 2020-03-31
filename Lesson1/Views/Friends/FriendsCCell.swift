//
//  FriendsCCell.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsCCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView! // привязка именно imageView, а не collection cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 10
        layer.cornerRadius = 25
    }
}


