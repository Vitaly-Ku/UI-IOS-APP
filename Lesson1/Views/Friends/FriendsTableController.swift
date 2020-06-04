//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

struct SectionFriend {
    var title: String
    var items: [Friend]
}

class FriendsTableController: UITableViewController {
    
    let vkRequest = VKRequests()
    var token: NotificationToken?
    var friendSection = [SectionFriend]()
//    var friendResponse = [Friend]()
    var friendResponse: Results<Friend>?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkRequest.getFriends() 
        pairTableAndRealm()
//        vkRequest.getFriends() { [weak self] in
//            self?.pairTableAndRealm()
//        }
    }
    
    func pairTableAndRealm() {
        do {
            let realm = try Realm()
            friendResponse = realm.objects(Friend.self).filter("firstName != %@","DELETED")
            self.token = friendResponse!.observe({ [weak self] (changes: RealmCollectionChange) in
                //                guard let tableView = self!.tableView else { return }
                switch changes {
                case .initial, .update:
                    let myFriendsDictionary = Dictionary.init(grouping: (self!.friendResponse!)) {
                        $0.lastName.prefix(1)
                    }
                    self!.friendSection = myFriendsDictionary.map {SectionFriend(title: String($0.key), items: $0.value)}
                    self!.friendSection.sort {$0.title < $1.title}
                    self!.tableView.reloadData()
                    //                case let .update(results, deletions, insertions, modifications):
                    //                    print("update ", results,
                    //                          "deletions ", deletions,
                    //                          "insertions ", insertions,
                    //                          "modifications ", modifications)
                    
                case .error(let error):
                    print(error)
                }
            })
        } catch  {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(Session.shared.token)
        animateTable()
        tableView.backgroundColor = colorBG
        searchBar.barTintColor = colorBG
        searchBar.tintColor = colorBG
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section].title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { friendSection.count }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .darkGray
        tableView.sectionIndexBackgroundColor = .init(displayP3Red: 31, green: 33, blue: 36, alpha: 0.0)
        return  friendSection.map {$0.title}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { friendSection[section].items.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableCell
        let friend = friendSection[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = friend.lastName + " " + friend.firstName
        if friend.online == 0 {
            cell.statusLabel.text = "не в сети"
            cell.statusLabel.textColor = .darkGray
        } else {
            cell.statusLabel.text = "в сети"
            cell.statusLabel.textColor = .systemGreen
        }
        AF.request((friend.photo100)).responseImage { response in
            do {
                let image = try response.result.get()
                cell.photo.image = image
            } catch {
                print("CAN'T GET AVATAR")
            }
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
                friendsCVC.friend = friendSection[indexPath.section].items[indexPath.row]
            }
        }
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

//    MARK: SearchBar Delegate

extension FriendsTableController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friendResponse!.filter{(user) -> Bool in return searchText.isEmpty ? true : user.firstName.lowercased().contains(searchText.lowercased()) || user.lastName.lowercased().contains(searchText.lowercased())
        }) { $0.lastName.prefix(1) }
        friendSection = friendsDictionary.map {SectionFriend(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title}
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
