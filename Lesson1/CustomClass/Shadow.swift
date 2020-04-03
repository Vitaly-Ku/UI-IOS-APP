//
//  File.swift
//  Lesson1
//
//  Created by Vit K on 01.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

@IBDesignable class Shadow: UIView { // класс для слоёв с тенью(вьюхам подписаться на него)
    
    @IBInspectable var Color: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var Opacity: CGFloat = 1 {
        didSet {
            self.updateOpacity()
        }
    }
    @IBInspectable var Radius: CGFloat = 7 {
        didSet {
            self.udateRadius()
        }
    }
    @IBInspectable var Offset: CGSize = .zero {
        didSet {
            self.updateOffset()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    var shadowLayer: CAShapeLayer { // вычисляемая переменная
        return self.layer as! CAShapeLayer
    }
    
    var masksToBounds: Bool = false
    
    func updateColors() {
        self.shadowLayer.shadowColor = self.Color.cgColor
    }
    func updateOpacity() {
        self.shadowLayer.shadowOpacity = Float(self.Opacity)
    }
    func udateRadius() {
        self.shadowLayer.shadowRadius = self.Radius
    }
    func updateOffset() {
        self.shadowLayer.shadowOffset = Offset
    }
}
