//
//  LoginRouter.swift
//  GBShop
//
//  Created by Olga Martyanova on 07/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import UIKit

final class LoginRouter: BaseRouter {
    func toProductList(user: User) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(ProductsListViewController.self)
        controller.user = user
        let navigationController = UINavigationController(rootViewController: controller)
        show(navigationController)
    }
    
    func toRegister() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(RegisterViewController.self)
        let navigationController = UINavigationController(rootViewController: controller)
        show(navigationController)
    }    
}
