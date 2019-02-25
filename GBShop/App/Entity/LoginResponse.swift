//
//  LoginResponse.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

/*
Structure for getting the authorization response from the network
*/

import Foundation
struct LoginResponse: Codable {
    let result: Int
    let user: User
}
