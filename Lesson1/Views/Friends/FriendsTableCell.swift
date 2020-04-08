//
//  FriendsCell.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var shadov: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
