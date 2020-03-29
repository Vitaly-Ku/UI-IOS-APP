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
        return password == "" && login == "" || login == " " && password == ""
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil) // кнопка на алерте
        alert.addAction(action) // добавить кнопку на алерт
        present(alert, animated: true, completion: nil)
    }
}
