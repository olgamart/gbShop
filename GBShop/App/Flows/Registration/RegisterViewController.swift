//
//  RegisterViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 07/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var router: RegisterRouter!    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var newUser = User()
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        registerButtonOutlet.layer.cornerRadius = 5        
        
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
    
    @IBAction func registerButton(_ sender: Any) {
        let registerService =  Di.container.resolve(RegisterService.self)
         let metrica = Di.container.resolve(Metrica.self)
        
        let  allDataNotCompleted = loginTextField.text == "" ||
            passwordTextField.text == "" ||
            confirmationPasswordTextField.text == "" ||
            nameTextField.text == "" ||
            lastNameTextField.text == "" ||
            emailTextField.text == ""
        
        let passwordNotConfirmated = passwordTextField.text !=
            confirmationPasswordTextField.text
        
        guard let email = emailTextField.text else {return}
        let emailNotValid = !(email.contains("@"))        
        
        if allDataNotCompleted {
            showErrorMessage(message: "Заполните все необходимые поля.")
        } else if passwordNotConfirmated {
            showErrorMessage(message: "Пароль не соответствует подтверждению.")
        } else if emailNotValid {
            showErrorMessage(message: "Введите правильно email.")
        } else {
            
            newUser.login = loginTextField.text
            newUser.password = passwordTextField.text
            newUser.name = passwordTextField.text
            newUser.lastname = lastNameTextField.text
            newUser.gender = genderTextField.text
            newUser.email = emailTextField.text
            
            registerService?.registerUser(userData: newUser) { message in
                if let responseMessage = message {
                    metrica?.log(event: "NEW_USER_WAS_REGISTRATED")
                    Log.log(event: "NEW_USER_WAS_REGISTRATED", category: Log.network)
                    self.showSuccessMessage(message: responseMessage, newUser: self.newUser)
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        router.toLogin(controller: self)
    }
    private func showErrorMessage(message: String) {
        let alter = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    
    private func showSuccessMessage(message: String, newUser: User) {
        
        guard let login = newUser.login else {return}
        let alter = UIAlertController(title: message, message: "Ваш логин: \(login)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            
            if let controller = self {
                controller.router.toLogin(controller: controller, user: newUser)
            }
            }
        )
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
