//
//  ViewController.swift
//  Lesson1
//
//  Created by Vit K on 22.03.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var kkk: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeAppleLogo()
        addAnimationPath()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardOn),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardOff),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @IBAction func ggg(_ sender: UIButton) {
        sender.pulsate()
    }
    @IBAction func loginButtonOn() { // связь кнопки с контроллером
    }
    
    @objc func keyboardOn(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardOff(notification: Notification) {
        scrollBottomConstraint.constant = 0
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool { // проверка входа
        switch identifier {
        case "loginSegue":
            let isAuth = checkUserData()
            if !isAuth {
                showLoginError()
            }
            return isAuth
        default:
           return true
        }
    }
    
    func checkUserData() -> Bool {
        let login = loginField.text
        let password = passwordField.text
        return password == "123456" && login == "admin" || login == "admin " && password == "123456"
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil) // кнопка на алерте
        alert.addAction(action) // добавить кнопку на алерт
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: Logo Animation
    
     var path : UIBezierPath!
    
        func addAnimationPath()  {
            let layer = CAShapeLayer()
            layer.path  = path.cgPath
            
            layer.strokeEnd = 0
            layer.lineWidth = 2
//            layer.borderColor = UIColor.red.cgColor
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 7
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowOpacity = 0.6
            layer.strokeColor = UIColor.lightGray.cgColor
            layer.fillColor = UIColor.darkGray.cgColor
            
            kkk.layer.addSublayer(layer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 3  // секунды
            animation.autoreverses = true
            animation.repeatCount = .infinity
            
            layer.add(animation, forKey: "line")
        }
        
        func makeAppleLogo()  {
            path = UIBezierPath()
            
            path.move(to: CGPoint(x: 3, y: 12))
            
            path.addLine(to: CGPoint(x: 3, y: 21)) // кошка
            path.addLine(to: CGPoint(x: 6, y: 24))
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
