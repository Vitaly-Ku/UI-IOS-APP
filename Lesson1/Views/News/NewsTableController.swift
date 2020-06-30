//
//  NewsTableController.swift
//  Lesson1
//
//  Created by Vit K on 06.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class NewsTableController: UITableViewController {
    
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
        super.viewWillAppear(animated)
        tableView.backgroundColor = colorBG
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return news?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        
        let currentNews = news!.items[indexPath.row]
        let id = currentNews.sourceID
        
        var authorName = ""
        
//        let rrr = OperationQueue()
//        rrr.addOperation {
            var authorImage : UIImage?
            if id > 0 {
                if let user = self.news!.profiles.first(where: {$0.id == abs(id)}) {
                    authorName = user.firstName + user.lastName
                    authorImage = UIImage.getImage(from: user.photo100)
                }
            } else {
                if let group = self.news!.groups.first(where: {$0.id == abs(id)}) {
                    authorName = group.name
                    authorImage = UIImage.getImage(from: group.photo200)
                }
            }
            
//            OperationQueue.main.addOperation {
                if let authorImage = authorImage {
                    cell.avatar.image = authorImage
                    cell.img.image = authorImage
                }
//            }
//        }

        let date = NSDate(timeIntervalSince1970: Double(currentNews.date))
        let currentDate = Date()
        let result = currentDate.timeIntervalSince(date as Date)
        
        cell.date.text = result.toRelativeDateTime()
        cell.comment.text = currentNews.text
        cell.name.text = authorName

        return cell
    }
}
