//
//  LoadingViewController.swift
//  Lesson1
//
//  Created by Vit K on 14.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var dotsLoading: UIView!
    @IBOutlet weak var leftDot: Roundinng!
    @IBOutlet weak var centerDot: Roundinng!
    @IBOutlet weak var rightDot: Roundinng!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: { self.leftDot.alpha = 0 })
        UIView.animate(withDuration: 1, delay: 0.3, options: .repeat, animations: { self.centerDot.alpha = 0 })
        UIView.animate(withDuration: 1, delay: 0.6, options: .repeat, animations: {self.rightDot.alpha = 0 })
        UIView.animate(withDuration: 0, delay: 2, options: [], animations: {self.dotsLoading.alpha = 0 })
        { (success) in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
            
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .repeat, animations: { self.leftDot.alpha = 0.0 })
//        UIView.animateKeyframes(withDuration: 1, delay: 0.3, options: .repeat, animations: { self.centerDot.alpha = 0.0 })
//        UIView.animateKeyframes(withDuration: 1, delay: 0.6, options: .repeat, animations: { self.rightDot.alpha = 0.0 })
        
        

    }
    

}
