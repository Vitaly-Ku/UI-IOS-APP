//
//  ButtonExtension.swift
//  Lesson1
//
//  Created by Vit K on 02.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import Foundation
import UIKit

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
