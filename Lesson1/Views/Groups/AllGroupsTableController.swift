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
}

extension AllGroupsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = groups.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}