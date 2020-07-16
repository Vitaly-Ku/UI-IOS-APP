//
//  NewsTableCell.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsTableCell: UITableViewCell {
    
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var comment: UILabel!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var likeCounter: UILabel!
    
    let currentDate = Date()
    
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
    
    func configure(news: News, newsItem: NewsItems) {
        
        let id = news.sourceID
        var authorImage = ""
        var authorName = ""
        
        if id > 0 {
            if let user = newsItem.profiles.first(where: {$0.id == abs(id)}) {
                authorName = user.firstName + user.lastName
                authorImage = user.photo100
            }
        } else {
            if let group = newsItem.groups.first(where: {$0.id == abs(id)}) {
                authorName = group.name
                authorImage = group.photo200
            }
        }
        
        avatar.af.setImage(withURL: URL(string: authorImage)!)
        img.af.setImage(withURL: URL(string: authorImage)!)
        
        comment.text = news.text
        name.text = authorName
        
        let dates = Date(timeIntervalSince1970: Double(news.date))
        let result = self.currentDate.timeIntervalSince(dates as Date)
        
        date.text = result.toRelativeDateTime()
    }
}
