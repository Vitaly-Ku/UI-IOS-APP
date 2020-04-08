//
//  NewsTableController.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class NewsTableController: UITableViewController {
    
    let news = NewsFactory.makeNews()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        
        cell.name.text = news[indexPath.row].name
        cell.avatar.image = news[indexPath.row].avatar
        cell.img.image = news[indexPath.row].photo
        cell.comment.text = news[indexPath.row].text
        
        let rightNow = Date()
        let calendar = Calendar.current
        let t = calendar.dateComponents([.minute], from: rightNow).minute!
        cell.date.text = String(t) + " минут назад"
        return cell
    }
}
