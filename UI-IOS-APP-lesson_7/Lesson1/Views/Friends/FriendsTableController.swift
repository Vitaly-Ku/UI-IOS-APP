//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

struct SectionFriend {
    var title: String
    var items: [Friends]
}

class FriendsTableController: UITableViewController {
    
    let friends = FriendsFactory.makeFriends()
    var friendSection = [SectionFriend]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        group(friends: friends)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { friendSection.count }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .darkGray
        tableView.sectionIndexBackgroundColor = .init(displayP3Red: 31, green: 33, blue: 36, alpha: 0.0)
      return  friendSection.map {$0.title}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { friendSection[section].items.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableCell // привязка ячеек к идентификатору и классу, кт заимствует общий VC
        cell.titleLabel.text = friendSection[indexPath.section].items[indexPath.row].title
        cell.statusLabel.text = friendSection[indexPath.section].items[indexPath.row].status
        cell.photo.image = friendSection[indexPath.section].items[indexPath.row].avatar
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
                friendsCVC.friend = friendSection[indexPath.section].items[indexPath.row]
            }
        }
    }
    
    func group(friends: [Friends]) {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.title.prefix(1) }
        friendSection = friendsDictionary.map {SectionFriend(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title}
    }
    
//    MARK: Animation of table list
    
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
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
            
            index += 1
        }
    }
}

// MARK: Searching extension

extension FriendsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            group(friends: friends)
        } else {
            let filteredUsers = friends.filter({$0.title.lowercased().contains(searchText.lowercased())})
            group(friends: filteredUsers)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        group(friends: friends)
        tableView.reloadData()
    }
}
