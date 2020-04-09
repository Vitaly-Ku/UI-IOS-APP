//
//  FriendsCCell.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsCollectionCell: UICollectionViewCell {
    
    @IBAction func pulseButton(_ sender: UIButton) { // экшен для пульсации кнопки
        sender.pulsate()
    }
    @IBOutlet weak var photo: UIImageView! // привязка именно imageView, а не collection cell
    @IBOutlet weak var likeButton: UIButton!
//    @IBOutlet weak var likeButtonCustom: UIView! // скрыта (в разработке)
    @IBOutlet weak var likesCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.lightGray.cgColor // рамки у фото в CVC
        layer.borderWidth = 7
        layer.cornerRadius = 25
        likeButton.setImage(#imageLiteral(resourceName: "heartRed"), for: .selected)
        likeButton.setImage(#imageLiteral(resourceName: "heartBlue"), for: .normal)

    }
    
    @IBAction func like() { // экшен для смены цвета кнопки и счётчика
        likeButton.isSelected.toggle()
        likesCounter.textColor = likeButton.isSelected ? .red : .systemBlue
        likesCounter.text = likeButton.isSelected ? "1" : "0"
    }
}



