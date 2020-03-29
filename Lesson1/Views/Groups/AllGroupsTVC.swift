//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.

import UIKit

// Вкладка "Все группы" контроллер ячеек

struct Groups {
    var title: String
    var photo: UIImage?
}

class AllGroupsTVC: UITableViewController {
    
    let groups: [Groups] = [
        Groups(title: "Футбол", photo: UIImage(named: "футбол")),
        Groups(title: "Музыка", photo: UIImage(named: "музыка")),
        Groups(title: "Кино", photo: UIImage(named: "кино")),
        Groups(title: "FC Barcelona", photo: UIImage(named: "барселона")),
        Groups(title: "FC Real Madrid", photo: UIImage(named: "реал")),
        Groups(title: "Кошки", photo: UIImage(named: "кошки")),
        Groups(title: "Макбуки", photo: UIImage(named: "макбуки"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count // привязка количества ячеек к массиву groups
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        
        let group = groups[indexPath.row] // индекс ячейки соответствует индексу в массиве groups
        cell.titleLabel.text = group.title // именование ячеек элементами массива
        cell.photo.image = group.photo

        return cell
    }
    

}
