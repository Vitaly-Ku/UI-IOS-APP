//
//  FriendsCVC.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class FriendsCollectionController: UICollectionViewController {
    
    var friend: Friends!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  friend.title
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { friend.photoes.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell", for: indexPath) as! FriendsCollectionCell
        
        
        
        cell.photo.image = friend.photoes[indexPath.row]
        return cell
    }
}

