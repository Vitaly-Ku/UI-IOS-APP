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
        let red: CGFloat = .random(in: 0...0.7)
        let green: CGFloat = .random(in: 0...0.7)
        let blue: CGFloat = .random(in: 0...0.7)
        
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
