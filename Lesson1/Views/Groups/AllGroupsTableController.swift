//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.

import UIKit
import Alamofire
import AlamofireImage

class AllGroupsTableController: UITableViewController {
    
    var filteredGroups = [GroupItem]()
    var searching = false
    var groupResponse: GroupResponse?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VKRequests.loadGroups { [weak self] (result) in
            switch result {
            case .success(let groupResponse):
                self?.groupResponse = groupResponse
                self?.tableView.reloadData()
//                groupResponse.response.items.map { (group) in
//                }
            case .failure(let error):
                print("error: ", error)
            }
        }
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
            return groupResponse?.response.items.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableCell 
        if searching {
            cell.titleLabel?.text = filteredGroups[indexPath.row].name
            AF.request((filteredGroups[indexPath.row].photo50)!).responseImage { response in
                do {
                 let image = try response.result.get()
                    cell.photo.image = image
                } catch {
                    print("CAN'T GET AVATAR")
                }
            }
        } else {
            cell.titleLabel?.text = groupResponse?.response.items[indexPath.row].name
            AF.request((groupResponse?.response.items[indexPath.row].photo50)!).responseImage { response in
                do {
                 let image = try response.result.get()
                    cell.photo.image = image
                } catch {
                    print("CAN'T GET AVATAR")
                }
            }
        }
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
//        if searching {
//            cell.titleLabel?.text = filteredGroups[indexPath.row].title
//            cell.photo.image = filteredGroups[indexPath.row].photo
//        } else {
//            cell.titleLabel?.text = groups[indexPath.row].title
//            cell.photo.image = groups[indexPath.row].photo
//        }
//        return cell
//    }
    
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

extension AllGroupsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        VKRequests.groupsSearch(searchText: searchText) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.groupResponse = searchResponse
                self?.searching = false
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        filteredGroups = (groupResponse?.response.items.filter({$0.name.lowercased().contains(searchText.lowercased())}))! as [GroupItem]
        searching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
