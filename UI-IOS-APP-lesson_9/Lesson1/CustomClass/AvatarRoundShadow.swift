//
//  File.swift
//  Lesson1
//
//  Created by Vit K on 01.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

 class Shadow: UIView { // класс для слоёв с тенью(вьюхам подписаться на него)
    override class var layerClass: AnyClass {
          return CAShapeLayer.self
      }
      var shadowLayer: CAShapeLayer { // вычисляемая переменная
          return self.layer as! CAShapeLayer
      }
    
    
    @IBInspectable var color: UIColor = .black {
        didSet { self.updateColors() }
    }
    @IBInspectable var opacity: CGFloat = 1 {
        didSet { self.updateOpacity() }
    }
    @IBInspectable var radius: CGFloat = 7 {
        didSet { self.udateRadius() }
    }
    @IBInspectable var offset: CGSize = .zero {
        didSet { self.updateOffset() }
    }
    
  
        
    func updateColors() {
        self.shadowLayer.shadowColor = self.color.cgColor
    }
    func updateOpacity() {
        self.shadowLayer.shadowOpacity = Float(self.opacity)
    }
    func udateRadius() {
        self.shadowLayer.shadowRadius = self.radius
    }
    func updateOffset() {
        self.shadowLayer.shadowOffset = offset
    }
}

 class Roundinng: UIImageView {
    override class var layerClass: AnyClass {
          return CAShapeLayer.self
      }
      var roundedLayer: CAShapeLayer {
          return self.layer as! CAShapeLayer
      }

    
    @IBInspectable var color: UIColor = .lightGray {
           didSet { self.updateColors() }
       }
    @IBInspectable var borderWidth: CGFloat = 3 {
        didSet { self.updateWidth() }
    }
    @IBInspectable var radius: CGFloat = 25 {
        didSet { self.udateRadius() }
    }
    
    
    
    func updateColors() {
        self.roundedLayer.borderColor = self.color.cgColor
    }
    func updateWidth() {
        self.roundedLayer.borderWidth = self.borderWidth
    }
    func udateRadius() {
        self.roundedLayer.cornerRadius = self.radius
    }
}


