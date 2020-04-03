//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsTableController: UITableViewController {
    
    let friends = FriendsFactory.makeFriends()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count // привязка количества ячеек к массиву friends
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // отображение заголовка на странице с фото в соответствии с названием выбранной ячейки
        if let friendsCVC = segue.destination as? FriendsCollectionController { // проверка перехода на нужный контроллер
            if let indexPath = tableView.indexPathForSelectedRow { // проверка выбранной строки перехода
                let friend = friends[indexPath.row]
                friendsCVC.friend = friend
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        
        let friend = friends[indexPath.row] // индекс ячейки соответствует индексу в массиве friends
        cell.titleLabel.text = friend.title // именование ячеек элементами массива
        let status = friends[indexPath.row]
        cell.statusLabel.text = status.status
        cell.photo.image = friend.avatar // photo - это аутлет фоки, avatar - проперти из структуры личных данных


        return cell
    }
}
