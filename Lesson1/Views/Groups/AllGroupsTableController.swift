//
//  AllGroupsViewController.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift
import FirebaseDatabase

class AllGroupsTableController: UITableViewController {
    
    let vkRequest = VKRequests()
    var filteredGroups = [Group]()

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = colorBG
        searchBar.barTintColor = colorBG
        searchBar.tintColor = colorBG
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! AllGroupsTableCell
        cell.titleLabel?.text = filteredGroups[indexPath.row].name
                   AF.request(filteredGroups[indexPath.row].photo200).responseImage { response in
                       do {
                        let image = try response.result.get()
                           cell.photo.image = image
                       } catch {
                           print("CAN'T GET AVATAR")
                       }
                   }
        return cell
    }
}

extension AllGroupsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        vkRequest.groupsSearch(searchText: searchText) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.filteredGroups = searchResponse
//                self?.searching = false
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        filteredGroups = (filteredGroups.filter({$0.name.lowercased().contains(searchText.lowercased())})) as [Group]
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }
}
