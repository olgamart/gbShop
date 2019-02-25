//
//  RegisterService.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for the registration of new user
*/

protocol RegisterService {
    /// Register user
    ///
    /// - Parameters:
    ///   - userData: New user data
    func registerUser(userData: User, completion: @escaping (String?) -> Void)
}

class RegisterServiceImpl: RegisterService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func registerUser(userData: User, completion: @escaping (String?) -> Void) {
        let request = RegisterRequest(baseUrl: baseUrl, userData: userData)
        networkService.reqest(request) { (response: RegisterResponse?) in
            completion(response?.userMessage)
        }
    }
}
