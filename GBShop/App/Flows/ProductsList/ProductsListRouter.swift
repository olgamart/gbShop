//
//  ProductsListRouter.swift
//  GBShop
//
//  Created by Olga Martyanova on 11/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import UIKit

final class ProductsListRouter: BaseRouter {
    
    func toLogin(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func toUserData(user: User) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(UserDataViewController.self)
        controller.user = user
        show(controller)
    }
    
    func toOneProduct(user: User) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(OneProductViewController.self)
        controller.user = user
        show(controller)
    }
    
    func toBasket() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(BasketViewController.self)        
        show(controller)
    }
    
    func toExit(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        if let controller =  UIApplication.shared.delegate?.window??.rootViewController as? LoginViewController {
            controller.loginTextField.text = ""
            controller.passwordTextField.text = ""
        }
    }
}
