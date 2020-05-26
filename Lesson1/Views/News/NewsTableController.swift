//
//  NewsTableController.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class NewsTableController: UITableViewController {
    
//    let news = NewsFactory.makeNews()
    var news : NewsItems?
    let vkRequests = VKRequests()

    override func viewDidLoad() {
        super.viewDidLoad()
        vkRequests.getNewsfeed(
            completion: {
                [weak self] array in
                self?.news = array
                self?.tableView.reloadData()
            }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundColor = colorBG
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let newsItems = news, !newsItems.items.isEmpty else {
            return 0
        }
        return newsItems.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        
        guard let newsItems = news, !newsItems.items.isEmpty else {
            return cell
        }
        let currentNews = newsItems.items[indexPath.row]
        let id = currentNews.sourceID
        
        var authorName = ""
        var authorImage : UIImage?
        if id > 0 {
            if let user = newsItems.profiles.first(where: {$0.id == abs(id)}) {
                authorName = user.firstName + user.lastName
                authorImage = UIImage.getImage(from: user.photo100)
            }
        } else {
            if let group = newsItems.groups.first(where: {$0.id == abs(id)}) {
                authorName = group.name
                authorImage = UIImage.getImage(from: group.photo200)
            }
        }
        
        let date = NSDate(timeIntervalSince1970: Double(currentNews.date))
        let currentDate = Date()
        let result = currentDate.timeIntervalSince(date as Date)
        
        cell.date.text = result.toRelativeDateTime()
        cell.comment.text = currentNews.text
        cell.name.text = authorName
        if let authorImage = authorImage {
            cell.avatar.image = authorImage
            cell.img.image = authorImage
        }
        return cell
    }
}
