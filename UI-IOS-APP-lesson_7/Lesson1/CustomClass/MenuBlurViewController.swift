//
//  MenuBlurViewController.swift
//  Lesson1
//
//  Created by Vit K on 15.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class MenuBlurViewController: UIViewController {
    
    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blur.layer.cornerRadius = 25
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 4
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        sideView.layer.shadowRadius = 7
        menuConstraint.constant = -155
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
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
