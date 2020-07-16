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
        vkRequests.getNewsfeed(startFrom: "",
            completion: {
                [weak self] array in
                self?.news = array
                self?.tableView.reloadData()
            }
        )
//        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = colorBG
    }
    
//    private func configureRefreshControl() {
//        refreshControl = UIRefreshControl()
//        refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка...")
//        refreshControl?.tintColor = .cyan
//        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
//    }
//
//    @objc func refreshNews() {
//        refreshControl?.beginRefreshing()
//        print("Обновление новостной ленты")
//        let mostFreshNewsDate = self.news?.items.first?.date ?? Int(Date().timeIntervalSince1970)
//        vkRequests.getNewsfeed(startFrom: String(mostFreshNewsDate + 1)) { items, dateFrom in
//            <#code#>
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell  
        cell.configure(news: news!.items[indexPath.row], newsItem: news!)
        return cell
    }
}
