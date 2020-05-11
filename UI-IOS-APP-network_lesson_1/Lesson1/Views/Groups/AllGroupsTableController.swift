//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.

import UIKit

class AllGroupsTableController: UITableViewController {
    
    var groups = GroupFactory.makeGroups()
    var filteredGroups = [Groups]()
    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        tableView.backgroundColor = colorBG
        searchBar.barTintColor = colorBG
        searchBar.tintColor = colorBG
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredGroups.count
        } else {
            return groups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        if searching {
            cell.titleLabel?.text = filteredGroups[indexPath.row].title
            cell.photo.image = filteredGroups[indexPath.row].photo
        } else {
            cell.titleLabel?.text = groups[indexPath.row].title
            cell.photo.image = groups[indexPath.row].photo
        }
        return cell
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