//
//  LoginViewController.swift
//  GBShop
//
//  Created by Olga Martyanova on 07/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var router: LoginRouter!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let metrica = Di.container.resolve(Metrica.self)
    var newUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
// Show newUser data after registration
// Using functional Swift
        newUser.map(setUser)
        
//        if let user = newUser {
//            loginTextField.text = user.login
//            passwordTextField.text = user.password
//        }
    }
    @IBAction func loginButton(_ sender: Any) {
        let authService = Di.container.resolve(AuthService.self)

        let completion: (User?) -> Void = {[weak self] user in
            if let user = user {
                self?.metrica?.log(event: "SUCCESSFUL_USER_AUTHORIZATION")
                Log.log(event: "SUCCESSFUL_USER_AUTHORIZATION", category: Log.network)
                self?.router.toProductList(user: user)
            } else {
                self?.metrica?.log(event: "NOT_SUCCESSFUL_USER_AUTHORIZATION")
                Log.log(event: "NOT_SUCCESSFUL_USER_AUTHORIZATION", category: Log.network)
                self?.showAuthError()
            }
        }
        
// Using functional Swift
        curry((authService?.login)!) <*> loginTextField.text <*> passwordTextField.text <*> completion
        
/*
        guard let login = loginTextField.text,
            let password = passwordTextField.text else {return}
        authService?.login(login: login, password: password) {[weak self] user in

            if let user = user {
                self?.router.toProductList(user: user)
            } else {
                self?.showAuthError()
            }
        }
*/
    }
    @IBAction func registerButton(_ sender: Any) {
        router.toRegister()
    }
    
    private func showAuthError() {
        let alter = UIAlertController(title: "Ошибка", message: "Неверные логин/пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    private func setUser(user: User) {
        loginTextField.text = user.login
        passwordTextField.text = user.password
    }
}
