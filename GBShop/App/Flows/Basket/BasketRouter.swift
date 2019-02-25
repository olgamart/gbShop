//
//  BasketRouter.swift
//  GBShop
//
//  Created by Olga Martyanova on 16/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import UIKit

final class BasketRouter: BaseRouter {
    
    func toBack(controller: UIViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
    
    func toExit(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        if let controller =  UIApplication.shared.delegate?.window??.rootViewController as? LoginViewController {
            controller.loginTextField.text = ""
            controller.passwordTextField.text = ""
        }
    }
}
