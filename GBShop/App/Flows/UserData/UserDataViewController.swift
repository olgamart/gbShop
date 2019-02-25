//
//  UserDataViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 07/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController {
    
    @IBOutlet var router: UserDataRouter!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var saveDataButtonOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.text = user?.login
        nameTextField.text = user?.name
        lastnameTextField.text = user?.lastname
        saveDataButtonOutlet.layer.cornerRadius = 5
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func saveDataButton(_ sender: Any) {
        let changeUserDataService =  Di.container.resolve(ChangeUserDataService.self)
        
        let login = user?.login
        guard let email = emailTextField.text else {return}
        let emailNotValid = !(email.contains("@"))
        
        if loginTextField.text == "" {
            showErrorMessage(message: "Заполните поле логин.")
            loginTextField.text = login
            
        } else if emailTextField.text != "" && emailNotValid {
            showErrorMessage(message: "Введите правильно email.")
        } else {
            
            user?.login = loginTextField.text
            user?.password = passwordTextField.text
            user?.name = nameTextField.text
            user?.lastname = lastnameTextField.text
            user?.gender = genderTextField.text
            user?.email = emailTextField.text
            user?.creditCard = creditCardTextField.text
            
            let completion: (Int?) -> Void = { result in
                if result == 1 {
                    self.showSaveDataMessage()
                }
            }
            
// Using functional Swift
     curry((changeUserDataService?.changeUserData)!) <*> user <*> completion
            
//            guard let user = user else {return}
//
//            changeUserDataService?.changeUserData(userData: user) { result in
//                if result == 1 {
//                    self.showSaveDataMessage()
//                }
//            }
            
            hideKeyboard()
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
         router.toExit(controller: self)
    }
    @IBAction func backButton(_ sender: Any) {
        router.toBack(controller: self)
    }
    
    private func showSaveDataMessage() {
        let alter = UIAlertController(title: nil, message: "Данные пользователя успешно изменены!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
    private func showErrorMessage(message: String) {
        let alter = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    @objc private func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        guard let kbSize = kbValue else {return}
        
        let contentInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: kbSize.cgRectValue.size.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}
