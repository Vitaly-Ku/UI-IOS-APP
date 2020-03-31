//
//  FriendsCVC.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsCVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//photoes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell", for: indexPath) as! FriendsCCell
        
//        let ph = photoes[indexPath.item] // .item в отличии от .row в строках таблицы
//        cell.photo.image = ph.photo // (cell - ячейка, photoggg - привязанный аутлет imageView, image - "системная переменная, ph - "переменная из этого метода", photo - экземпляр структуры Photoes)
        
        let fff = friends[0].photoes[indexPath.row]
        cell.photo.image = fff
        
        
        return cell
    }
}
