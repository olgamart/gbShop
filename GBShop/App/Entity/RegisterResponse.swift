//
//  RegisterResponse.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

/*
 Structure for getting the register response from the network
*/

struct RegisterResponse: Codable {
    let result: Int
    let userMessage: String
}
