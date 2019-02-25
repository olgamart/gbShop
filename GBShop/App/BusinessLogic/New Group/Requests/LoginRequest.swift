//
//  LoginRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
Structure for the creating authorization request to the network
*/

struct LoginRequest: RequestRouter {
    let baseUrl: URL
    let login: String
    let password: String

    let method: HTTPMethod = .post
    let path: String = "login"
    var parameters: Parameters? {
        return [
            "username": login,
            "password": password
        ]
    }
}
