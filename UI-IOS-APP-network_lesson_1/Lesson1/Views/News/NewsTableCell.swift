//
//  NewsTableCell.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(#imageLiteral(resourceName: "heartRed"), for: .selected)
        likeButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
    }
    
    @IBAction func pulseButton(_ sender: UIButton) { // экшен для пульсации кнопки
        sender.pulsate()
    }
    
    @IBAction func like() {
        likeButton.isSelected.toggle()
        likeCounter.textColor = likeButton.isSelected ? .red : .darkGray
        likeCounter.text = likeButton.isSelected ? "1" : "0"
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: .autoreverse, animations: { self.likeCounter.frame.origin.y += 3 })
        self.likeCounter.frame.origin.y -= 3
    }
}
