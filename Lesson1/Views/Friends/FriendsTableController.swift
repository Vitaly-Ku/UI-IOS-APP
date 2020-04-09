//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

struct Section {
    var title: String
    var items: [Friends]
}

class FriendsTableController: UITableViewController {
    
    var friends = FriendsFactory.makeFriends()
    var filteredUsers = [Friends]()
    var friendSection = [Section]()

    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsDictionary = Dictionary.init(grouping: friends) {
            $0.title.prefix(1)
        }
        friendSection = friendsDictionary.map {Section(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title}
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return 1
        } else {
            return friendSection.count
        }
        
        
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { friendSection[section].title }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { friendSection.map {$0.title} }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredUsers.count
        } else {
            return friendSection[section].items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableCell // привязка ячеек к идентификатору и классу, кт заимствует общий VC
        if searching {
            cell.titleLabel?.text = filteredUsers[indexPath.row].title
            cell.statusLabel.text = filteredUsers[indexPath.row].status
            cell.photo.image = filteredUsers[indexPath.row].avatar
        } else {
            cell.titleLabel.text = friendSection[indexPath.section].items[indexPath.row].title
            cell.statusLabel.text = friendSection[indexPath.section].items[indexPath.row].status
            cell.photo.image = friendSection[indexPath.section].items[indexPath.row].avatar
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // хедеры
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 5, width: view.frame.width - 10, height: 20))
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = friendSection[section].title
        view.addSubview(lbl)
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // отображение заголовка на странице с фото в соответствии с названием выбранной ячейки
           if let friendsCVC = segue.destination as? FriendsCollectionController { // проверка перехода на нужный контроллер
               if let indexPath = tableView.indexPathForSelectedRow { // проверка выбранной строки перехода
                   if searching {
                       friendsCVC.friend = filteredUsers[indexPath.row]
                       
                   } else {
                       friendsCVC.friend = friendSection[indexPath.section].items[indexPath.row]
                   }
               }
           }
       }
}

// MARK: Searching extension

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
