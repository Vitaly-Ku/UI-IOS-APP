//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

// Вкладка "Все группы" контроллер ячеек

class AllGroupsViewController: UITableViewController {
    
    let groups: [String] = ["Футбол", "Музыка", "Кино"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count // привязка количества ячеек к массиву groups
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        
        let group = groups[indexPath.row] // индекс ячейки соответствует индексу в массиве groups
        cell.titleLabel.text = group // именование ячеек элементами массива

        return cell
    }
    

}
