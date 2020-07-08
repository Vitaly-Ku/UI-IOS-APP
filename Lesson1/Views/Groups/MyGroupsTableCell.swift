//
//  MyGroupsCell.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import AlamofireImage

class MyGroupsTableCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photo: UIImageView!
    
    func configureMyGroupsCell(group: Group) {
        titleLabel.text = group.name
        let urlGroupmage = group.photo200
        photo.af.setImage(withURL: URL(string: urlGroupmage)!)
    }
}
