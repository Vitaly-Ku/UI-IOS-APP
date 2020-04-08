//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsTableController: UITableViewController {
    
    var friends = FriendsFactory.makeFriends()
    var filteredUsers = [Friends]()
    var searching = false
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredUsers.count
        } else {
            return friends.count
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // отображение заголовка на странице с фото в соответствии с названием выбранной ячейки
        if let friendsCVC = segue.destination as? FriendsCollectionController { // проверка перехода на нужный контроллер
            if let indexPath = tableView.indexPathForSelectedRow { // проверка выбранной строки перехода
                if searching {
                    friendsCVC.friend = filteredUsers[indexPath.row]
                    
                } else {
                    friendsCVC.friend = friends[indexPath.row]
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        if searching {
            cell.titleLabel?.text = filteredUsers[indexPath.row].title
            cell.statusLabel.text = filteredUsers[indexPath.row].status
            cell.photo.image = filteredUsers[indexPath.row].avatar
        } else {
            cell.titleLabel?.text = friends[indexPath.row].title
            let status = friends[indexPath.row]
            cell.statusLabel.text = status.status
            cell.photo.image = friends[indexPath.row].avatar // photo - это аутлет фоки, avatar - проперти из структуры личных данных
        }
        return cell
    }
}

extension FriendsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = friends.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
