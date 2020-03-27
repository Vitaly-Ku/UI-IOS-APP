//
//  FriendsPhotoCollection.swift
//  Lesson1
//
//  Created by Vit K on 27.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    let friends: [String] = ["Алиса", "Несси", "Рина"]
    let statuses: [String] = ["Жена", "Кошка", "Кошка"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count // привязка количества ячеек к массиву friends
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        
        let friend = friends[indexPath.row] // индекс ячейки соответствует индексу в массиве friends
        cell.titleLabel.text = friend // именование ячеек элементами массива
        
        let status = statuses[indexPath.row]
        cell.statusLabel.text = status

        return cell
    }
}
