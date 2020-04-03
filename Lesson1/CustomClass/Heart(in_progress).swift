////
////  Heart.swift
////  Lesson1
////
////  Created by Vit K on 01.04.2020.
////  Copyright © 2020 Vitaly Kulagin. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class TestView: UIView {
//    override func draw(_ rect: CGRect) { // сердечко
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        let path = UIBezierPath()
//
//        context.setStrokeColor(UIColor.systemBlue.cgColor)
//        context.setFillColor(UIColor.red.cgColor)
//        context.setLineWidth(CGFloat(5))
//        path.move(to: CGPoint(x: 15, y: 10)) // сердечко
//        path.addLine(to: CGPoint(x: 11, y: 7))
//        path.addLine(to: CGPoint(x: 7, y: 10))
//        path.addLine(to: CGPoint(x: 7, y: 15))
//        path.addLine(to: CGPoint(x: 15, y: 24))
//        path.addLine(to: CGPoint(x: 23, y: 15))
//        path.addLine(to: CGPoint(x: 23, y: 10))
//        path.addLine(to: CGPoint(x: 19, y: 7))
//        path.close()
//        path.stroke()
//        context.addPath(path.cgPath)
//        context.strokePath()
//
////        context.closePath()
////        context.strokePath()
//
//    }
//
//    override class var layerClass: AnyClass {
//           return CAShapeLayer.self
//       }
//       var heartLayer: CAShapeLayer { // вычисляемая переменная
//           return self.layer as! CAShapeLayer
//       }
//       var masksToBounds: Bool = false
//
//
//
//    @IBInspectable var borderColor: UIColor = .clear {
//        didSet {
//            self.updateColors()
//        }
//    }
//    @IBInspectable var radius: CGFloat = 0 {
//        didSet {
//            self.udateRadius()
//        }
//    }
//    @IBInspectable var borderWigth: CGFloat = 1 {
//        didSet {
//            self.updateOffset()
//        }
//    }
//    @IBInspectable var background: UIColor = .clear {
//        didSet {
//            self.udateBackground()
//        }
//    }
//
//
//    func updateColors() {
//        self.heartLayer.borderColor = self.borderColor.cgColor
//    }
//    func udateRadius() {
//        self.heartLayer.shadowRadius = self.radius
//    }
//    func updateOffset() {
//        self.heartLayer.borderWidth = borderWigth
//    }
//    func udateBackground() {
//        self.heartLayer.backgroundColor = self.background.cgColor
//    }
//}
