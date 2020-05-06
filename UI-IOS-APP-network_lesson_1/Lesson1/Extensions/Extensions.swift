//
//  Extensions.swift
//  Lesson1
//
//  Created by Vit K on 27.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let red: CGFloat = .random(in: 0...1)
        let green: CGFloat = .random(in: 0...1)
        let blue: CGFloat = .random(in: 0...1)
        
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIButton { // расширение для кнопок
    func pulsate() { // пульсация
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.60
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.9
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
                              -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
                              -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        return nil
    }
}

//extension FriendsTableController: UISearchBarDelegate {
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            group(friends: friends)
//        } else {
//            let filteredUsers = friends.filter({$0.title.lowercased().contains(searchText.lowercased())})
//            group(friends: filteredUsers)
//        }
//        tableView.reloadData()
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        group(friends: friends)
//        tableView.reloadData()
//    }
//}

extension FriendsCollectionController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return friend.photoes.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView = view as? UIImageView
        }
        
        imageView.image = friend.photoes[index]
        return imageView
    }
}

//extension FriendsCollectionController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = floor(collectionView.bounds.width / 3)
//        return CGSize(width: cellWidth, height: cellWidth)
//    }
//}

extension AllGroupsTableController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = groups.filter({$0.title.lowercased().contains(searchText.lowercased())})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
