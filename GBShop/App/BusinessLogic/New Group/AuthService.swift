//
//  AuthService.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
/*
This class sends authorization request to the server
*/

protocol AuthService {
    /// Authorize user
    ///
    /// - Parameters:
    ///   - login: Login
    ///   - password: Password
    func login(login: String, password: String, completion: @escaping (User?) -> Void)
}

class AuthServiceImpl: AuthService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func login(login: String, password: String, completion: @escaping (User?) -> Void) {
        let request = LoginRequest(baseUrl: baseUrl, login: login, password: password)
        networkService.reqest(request) { (response: LoginResponse?) in
            completion(response?.user)            
        }
    }
}
