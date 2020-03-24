//
//  ViewController.swift
//  Lesson1
//
//  Created by Vit K on 22.03.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
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

    @IBAction func loginButtonOn() {
        let login = loginField.text!
        let password = passwordField.text!
        
        if login == "admin" && password == "333" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
    }
    
    @objc func keyboardOn(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        scrollBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardOff(notification: Notification) {
        scrollBottomConstraint.constant = 0
    }
}
