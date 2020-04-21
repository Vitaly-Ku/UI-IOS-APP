//
//  MyGroupsTVC.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class MyGroupsTableController: UITableViewController {
    
    var groups = [Groups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! MyGroupsTableCell
        let group = groups[indexPath.row]
        cell.titleLabel.text = group.title
        cell.photo.image = group.photo
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) { // unwind выход из общих групп к моим группам
        if segue.identifier == "addGroup" { // проверка идентификатора перехода
            let allGroupsTVC = segue.source as! AllGroupsTableController // контроллер, с которого переходим
            if let indexPath = allGroupsTVC.tableView.indexPathForSelectedRow { // если indexPath = индекс выделенной ячейки
                
                if allGroupsTVC.searching {
                    let gr = allGroupsTVC.filteredGroups[indexPath.row] // получить группу по индексу
                    if !groups.contains(where: { g -> Bool in // проверка на наличие строки в избранном
                        return gr.title == g.title}) {
                        groups.append(gr)
                        tableView.reloadData()
                    }
                } else {
                    let group = allGroupsTVC.groups[indexPath.row]
                    if !groups.contains(where: { g -> Bool in
                        return group.title == g.title}) {
                        groups.append(group)
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // изменение строки (удаление/ или вставка)
        if editingStyle == .delete { // Если была нажата кнопка «Удалить»
            groups.remove(at: indexPath.row) // Удаляем группу из массива
            tableView.deleteRows(at: [indexPath], with: .fade) // удаляем строку из таблицы
        }
    }
}
