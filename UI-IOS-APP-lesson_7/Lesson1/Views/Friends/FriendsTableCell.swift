//
//  FriendsCell.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsTableCell: UITableViewCell {
    
//        let gr = CAGradientLayer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var shadov: UIView!
    
    @IBAction func avatarRotate() {
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: .autoreverse, animations: {
            self.photo.transform = CGAffineTransform(rotationAngle: 360)
        }) { _ in
            self.photo.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.layer.insertSublayer(gr, at: 0)
//        gr.colors = [
//            UIColor.lightGray.cgColor,
//            UIColor.darkGray.cgColor
//        ]
//        gr.startPoint = CGPoint(x: 0.5, y: 0)
//        gr.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gr.frame = contentView.bounds
//    }
    
    
}
