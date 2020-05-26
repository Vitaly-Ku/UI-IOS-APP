//
//  FriendsCVC.swift
//  Lesson1
//
//  Created by Vit K on 28.03.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class FriendsCollectionController: UICollectionViewController {
    
    let vkRequest = VKRequests()
    
    //    var friend: Friends!
    @IBOutlet weak var iCarouselView: iCarousel!
    var fotoResponse = [Photo]()
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataPhotos()
        vkRequest.loadPhotos(friendId: friend!.id) { [weak self] in
            self?.loadDataPhotos()
        }

        title = friend?.firstName
        iCarouselView.type = .invertedCylinder
        iCarouselView.contentMode = .scaleAspectFill
        iCarouselView.isPagingEnabled = true
    }
    
    func loadDataPhotos() {
        do {
            let realm = try Realm()
            let photos = realm.objects(Photo.self)
            self.fotoResponse = Array(photos)
            self.iCarouselView.reloadData()
        } catch  {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.backgroundColor = colorBG
        iCarouselView.backgroundColor = colorBG
    }
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    //
    //    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { friend.photoes.count }
    //
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell", for: indexPath) as! FriendsCollectionCell
    //        cell.photo.image = friend.photoes[indexPath.row]
    //        return cell
    //    }
}

extension FriendsCollectionController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int { fotoResponse.count }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView = view as? UIImageView
        }
        imageView.af.setImage(withURL: URL(string: (fotoResponse[index].url))!)
        return imageView
    }
}

//extension FriendsCollectionController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = floor(collectionView.bounds.width / 3)
//        return CGSize(width: cellWidth, height: cellWidth)
//    }
//}
