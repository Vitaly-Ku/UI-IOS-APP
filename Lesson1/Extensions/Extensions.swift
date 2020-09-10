//
//  Extensions.swift
//  Lesson1
//
//  Created by Vit K on 27.04.2020.
//  Copyright © 2020 Vitaly Kulagin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let invisible = UIColor(red: 31 / 255.0, green: 33 / 255.0, blue: 36 / 255.0, alpha: 0.3)
    
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

extension UIImage {
    static func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}

extension TimeInterval {

    func toRelativeDateTime() -> String {

        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        if hours > 24{
            return ""
        } else if hours > 1 {
            return "\(hours) часов назад"
        } else if minutes > 1 {
            return "\(minutes) минут назад"
        } else {
            return "\(seconds) секунд назад"
        }
    }
}
