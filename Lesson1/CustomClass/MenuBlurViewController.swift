//
//  MenuBlurViewController.swift
//  Lesson1
//
//  Created by Vit K on 15.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class MenuBlurViewController: UIViewController {
    
    let arr = [
    UIImage(named: "a111"),
    UIImage(named: "a222"),
    UIImage(named: "a333"),
    UIImage(named: "a444"),
    UIImage(named: "a555"),
    ]

    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var yellowView: UIImageView!
    
    var animator: UIViewPropertyAnimator!
    var direction = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blur.layer.cornerRadius = 25
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 4
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        sideView.layer.shadowRadius = 7
        menuConstraint.constant = 0
        
        self.menuConstraint.constant = -155
        
        self.yellowView.image = self.arr[0]
        
    }
    var i = 0
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        switch sender.state {

        case .began: break

        case .changed:
            let translation = sender.translation(in: self.view).x

            if translation > 0 {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                    self.yellowView.alpha = 0
                    self.yellowView.transform.tx += translation
                    self.yellowView.transform = CGAffineTransform(rotationAngle: 70)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                    self.yellowView.alpha = 0
                    self.yellowView.transform.tx -= -translation
                    self.yellowView.transform = CGAffineTransform(rotationAngle: -70)
                }, completion: nil)
            }

        case .ended:
            if i < self.arr.count - 1 {
                i += 1
            } else {
                i = 0
                self.yellowView.image = self.arr.first!!
            }

            self.yellowView.image = self.arr[i]
            self.yellowView.transform = .identity
            UIView.animate(withDuration: 0.5, animations: {
                self.yellowView.alpha = 1
            })

        default:
            break
        }
        


//         MARK: Боковое меню по свайпу
        
//        switch sender.state {
//        case .began, .changed:
//            let translation = sender.translation(in: self.view).x
//            if translation > 0 {
//                if menuConstraint.constant < 20 {
//                    UIView.animate(withDuration: 0.2) {
//                        self.menuConstraint.constant += translation / 10
//                        self.view.layoutIfNeeded()
//                    }
//                }
//            } else {
//                if menuConstraint.constant > -175 {
//                    UIView.animate(withDuration: 0.2) {
//                        self.menuConstraint.constant += translation / 10
//                        self.view.layoutIfNeeded()
//                    }
//                }
//            }
//        case .ended:
//            if menuConstraint.constant < -100 {
//                UIView.animate(withDuration: 0.2) {
//                    self.menuConstraint.constant = -155
//                    self.view.layoutIfNeeded()
//                }
//            } else {
//                UIView.animate(withDuration: 0.2) {
//                    self.menuConstraint.constant = 0
//                    self.view.layoutIfNeeded()
//                }
//            }
//        default:
//            break
//        }
    }
}
