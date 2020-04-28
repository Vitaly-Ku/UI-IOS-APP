//
//  MenuBlurViewController.swift
//  Lesson1
//
//  Created by Vit K on 15.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

var colorBG: UIColor = .brown


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var iPhone: UIImageView!
    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blur.layer.cornerRadius = 25
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 4
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        sideView.layer.shadowRadius = 7
        menuConstraint.constant = 0
        
        self.menuConstraint.constant = -155
        
        view.backgroundColor = colorBG
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.randomBGColor()
        }
    }
    
    func randomBGColor() {
        colorBG = .random()
        view.backgroundColor = colorBG
        tabBarController?.tabBar.tintColor = colorBG
//        navigationController?.navigationBar.tintColor = colorBG
//        navigationController?.navigationBar.barTintColor = colorBG        
    }
        
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

//         MARK: Боковое меню по свайпу
        
        switch sender.state {
        case .began, .changed:
            let translation = sender.translation(in: self.view).x
            if translation > 0 {
                if menuConstraint.constant < 20 {
                    UIView.animate(withDuration: 0.2) {
                        self.menuConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    }
                }
            } else {
                if menuConstraint.constant > -175 {
                    UIView.animate(withDuration: 0.2) {
                        self.menuConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    }
                }
            }
        case .ended:
            if menuConstraint.constant < -100 {
                UIView.animate(withDuration: 0.2) {
                    self.menuConstraint.constant = -155
                    self.view.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.menuConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        default:
            break
        }
    }
}
