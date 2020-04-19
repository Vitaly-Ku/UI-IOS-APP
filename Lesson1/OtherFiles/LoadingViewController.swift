//
//  LoadingViewController.swift
//  Lesson1
//
//  Created by Vit K on 14.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var logoCat: UIView!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 2.7, options: [], animations: {self.logoCat.alpha = 0 })
        { (success) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCatLogo()
        addAnimationPath()
    }
    
    var path : UIBezierPath!
    
    func addAnimationPath()  {
        
        let layer = CAShapeLayer()
        layer.path  = path.cgPath
        layer.strokeEnd = 0
        layer.lineWidth = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.6
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.darkGray.cgColor
        
        logoCat.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0
        animation.toValue = 1
        
        let animationEnd = CABasicAnimation(keyPath: "strokeEnd")
        animationEnd.fromValue = 0
        animationEnd.toValue = 1.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [animation, animationEnd]
        
        layer.add(animationGroup, forKey: "line")
    }
    
    func makeCatLogo()  {
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: 3, y: 21))
        path.addLine(to: CGPoint(x: 6, y: 24)) // кошка
        path.addLine(to: CGPoint(x: 69, y: 24))
        path.addLine(to: CGPoint(x: 69, y: 15))
        path.addLine(to: CGPoint(x: 60, y: 15))
        path.addLine(to: CGPoint(x: 60, y: 12))
        path.addLine(to: CGPoint(x: 63, y: 12))
        path.addLine(to: CGPoint(x: 63, y: 9))
        path.addLine(to: CGPoint(x: 57, y: 9))
        path.addLine(to: CGPoint(x: 57, y: 18))
        path.addLine(to: CGPoint(x: 66, y: 18))
        path.addLine(to: CGPoint(x: 66, y: 21))
        path.addLine(to: CGPoint(x: 54, y: 21))
        path.addLine(to: CGPoint(x: 54, y: 15))
        path.addLine(to: CGPoint(x: 45, y: 6))
        path.addLine(to: CGPoint(x: 27, y: 6))
        path.addLine(to: CGPoint(x: 21, y: 12))
        path.addLine(to: CGPoint(x: 21, y: 3))
        path.addLine(to: CGPoint(x: 18, y: 3))
        path.addLine(to: CGPoint(x: 12, y: 9))
        path.addLine(to: CGPoint(x: 12, y: 3))
        path.addLine(to: CGPoint(x: 9, y: 3))
        path.addLine(to: CGPoint(x: 3, y: 12))
        path.addLine(to: CGPoint(x: 3, y: 21))
        
        path.move(to: CGPoint(x: 6, y: 12)) // глаз
        path.addLine(to: CGPoint(x: 6, y: 15))
        path.addLine(to: CGPoint(x: 9, y: 15))
        path.addLine(to: CGPoint(x: 9, y: 12))
        
        path.move(to: CGPoint(x: 15, y: 12)) // глаз
        path.addLine(to: CGPoint(x: 15, y: 15))
        path.addLine(to: CGPoint(x: 18, y: 15))
        path.addLine(to: CGPoint(x: 18, y: 12))
        
        path.close()
    }
}
