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

class FriendsCollectionController: UICollectionViewController {
    
    let vkRequest = VKRequests()
    
    //    var friend: Friends!
    @IBOutlet weak var iCarouselView: iCarousel!
    var fotoResponse: PhotoResponse?
    var friend: FriendItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkRequest.loadPhotos(friendId: String(friend!.id)) { [weak self] (result) in
            switch result {
            case .success(let fotoResponse):
                self?.fotoResponse = fotoResponse
                self?.iCarouselView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

        title = friend?.firstName
        iCarouselView.type = .coverFlow2
        iCarouselView.contentMode = .scaleAspectFill
        iCarouselView.isPagingEnabled = true
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
    func numberOfItems(in carousel: iCarousel) -> Int { fotoResponse?.response.items.count ?? 1 }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView = view as? UIImageView
        }
        
//        fotoResponse?.response.items[index].sizes[index]
        AF.request((friend?.photo100)!).responseImage { response in
            do {
             let image = try response.result.get()
                imageView.image = image
                print(self.fotoResponse?.response.items.count, " кол-во фоток")

            } catch {
                print("CAN'T GET AVATAR")
            }
        }
        return imageView
    }
}

//extension FriendsCollectionController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = floor(collectionView.bounds.width / 3)
//        return CGSize(width: cellWidth, height: cellWidth)
//    }
//}
