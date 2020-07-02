//
//  NewsTableCell.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {

    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet private weak var comment: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
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
    
    func configure(news: News, n: NewsItems) {
        
        let id = news.sourceID
        var authorImage : UIImage?
        var authorName = ""
        
        if id > 0 {
            if let user = n.profiles.first(where: {$0.id == abs(id)}) {
                authorName = user.firstName + user.lastName
                authorImage = UIImage.getImage(from: user.photo100)
            }
        } else {
            if let group = n.groups.first(where: {$0.id == abs(id)}) {
                authorName = group.name
                authorImage = UIImage.getImage(from: group.photo200)
            }
        }
        
        if let authorImage = authorImage {
            avatar.image = authorImage
            img.image = authorImage
        }
        
        comment.text = news.text
        name.text = authorName
    }
}
