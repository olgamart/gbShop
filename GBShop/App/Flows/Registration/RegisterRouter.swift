//
//  RegisterRouter.swift
//  GBShop
//
//  Created by Olga Martyanova on 07/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import UIKit

final class RegisterRouter: BaseRouter {
    func toLogin(controller: UIViewController, user: User) {
        controller.dismiss(animated: true, completion: nil)
        
        if let viewConnroller = controller.presentingViewController as? LoginViewController {
            viewConnroller.newUser = user
        }
    }
    
    func toLogin(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
