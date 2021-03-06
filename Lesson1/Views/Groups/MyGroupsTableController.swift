//
//  MyGroupsTVC.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class MyGroupsTableController: UITableViewController {
    
    let vkRequest = VKRequests()
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataGroup()
        vkRequest.loadGroups() { [weak self]  in
            self?.loadDataGroup()
        }
    }
    
    func loadDataGroup() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.groups = Array(groups)
            self.tableView?.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
        tableView.backgroundColor = colorBG
        print(groups)
        navigationItem.rightBarButtonItem?.tintColor = colorBG
        navigationItem.titleView?.tintColor = colorBG
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! MyGroupsTableCell
        cell.configureMyGroupsCell(group: groups[indexPath.row])
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) { // unwind выход из общих групп к моим группам
        if segue.identifier == "addGroup" { // проверка идентификатора перехода
            let allGroupsTVC = segue.source as! AllGroupsTableController // контроллер, с которого переходим
            if let indexPath = allGroupsTVC.tableView.indexPathForSelectedRow { // если indexPath = индекс выделенной ячейки
                
                let gr = allGroupsTVC.filteredGroups[indexPath.row] // получить группу по индексу
                if !groups.contains(where: { g -> Bool in // проверка на наличие строки в избранном
                    return gr.name == g.name}) {
                    groups.append(gr)
                    tableView.reloadData()
                    vkRequest.joinGroup(for: gr.id)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // изменение строки (удаление/ или вставка)
        if editingStyle == .delete { // Если была нажата кнопка «Удалить»
            vkRequest.leaveGroup(for: groups[indexPath.row].id)
            groups.remove(at: indexPath.row) // Удаляем группу из массива
            tableView.deleteRows(at: [indexPath], with: .fade) // удаляем строку из таблицы
        }
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            cell.alpha = 0
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
            
            index += 1
        }
    }
}

