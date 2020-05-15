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
    
    @IBOutlet weak var iCarouselView: iCarousel!
    var fotoResponse: PhotoResponse?
    
//    var friend: Friends!
    var friend: FriendItem?
    var foto: Sizes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func foto1(param: Parameters) {
            AF.request(VKServices.shared.baseUrl + VKServices.Method.getPhotos.methodName, parameters: param).responseJSON { response in
                guard let value = response.data else { return }
                switch (response.result) {
                case .success(_):
                    do {
                        let json = try JSONDecoder().decode(Sizes.self, from: value)
                        self.foto = json
                        print(json, " ПОЛУЧИЛИ JSON")
                    } catch let error {
                        print(error, "ошибка, не распарсилось")
                    }
                case .failure(let error):
                    print("errrrrrrrrrror", error)
                }
                print(value)
            }
        }
        foto1(param: ["access_token" : Session.shared.token, "extended" : 1, "v" : "5.103", "album_id" : "profile", "owner_id" : "\(String(describing: friend?.id))"])
        
        

        title = friend?.first_name
        iCarouselView.type = .coverFlow2
        iCarouselView.contentMode = .scaleAspectFill
        iCarouselView.isPagingEnabled = true
//        print(friend as Any)
//        print(friend?.photo_100?.count as Any)
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
    func numberOfItems(in carousel: iCarousel) -> Int { 2 }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView = view as? UIImageView
        }
//        imageView.image = friend.photoes[index]
        AF.request((friend?.photo_100)!).responseImage { response in
            do {
             let image = try response.result.get()
                imageView.image = image
            } catch {
                print("CAN'T GET AVATAR")
            }
        }
        return imageView
    }
}
