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
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var passTitle: UILabel!
    @IBOutlet weak var logoCat: UIView!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var threeCatsLogo: UIImageView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeCatLogo()
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
        
        addPanGesture(view: logoCat)
        view.bringSubviewToFront(logoCat)
        self.loginButton.layer.cornerRadius = 5
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = colorBG
    }
    
//    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        UIView.animate(withDuration: 0.3) {
//            self.randomBGColor()
//        }
//    }
//    
//    func randomBGColor() {
//        view.backgroundColor = .random()
//    }
    
    @IBAction func launchPulsate(_ sender: UIButton) {
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
    // MARK: Hide cat gesture animation
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(LoginController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let view = sender.view!
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: view, sender: sender)
        case .ended:
            if view.frame.intersects(threeCatsLogo.frame) {
                deleteView(view: view)
                self.loginField.alpha = 0
                self.passwordField.alpha = 0
                UIView.animate(withDuration: 5, delay: 3, options: [], animations: {
                    self.loginField.alpha = 1
                    self.passwordField.alpha = 1
                })
                deleteView(view: loginTitle)
                deleteView(view: passTitle)
                UIView.animateKeyframes(withDuration: 0.5, delay: 0.3, options: .allowUserInteraction, animations: {
                })
            }
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
}
