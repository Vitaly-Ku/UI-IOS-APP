//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.

import UIKit

class AllGroupsTableController: UITableViewController {
    
    let groups = GroupFactory.makeGroups()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count // привязка количества ячеек к массиву groups
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        
        let group = groups[indexPath.row] // индекс ячейки соответствует индексу в массиве groups
        cell.titleLabel.text = group.title // именование ячеек элементами массива
        cell.photo.image = group.photo

        return cell
    }
    

}
