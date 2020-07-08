//
//  AllGroupsCell.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import AlamofireImage

class AllGroupsTableCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photo: UIImageView!
    
    func configureAllGroupsCell(group: Group) {
        titleLabel.text = group.name
        
        let urlGroupImage = group.photo200
        photo.af.setImage(withURL: URL(string: urlGroupImage)!)
    }
}
