//
//  CustomGradient.swift
//  Lesson1
//
//  Created by Vit K on 20.05.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

class CustomGradient: UIView {
    
    var gradientLayer = CAGradientLayer()
    var vertical: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradientLayer.frame = self.bounds
        
        if gradientLayer.superlayer == nil {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
            gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0, 0.5, 1]
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
