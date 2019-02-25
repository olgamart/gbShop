//
//  OrderPaymentResponse.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
/*
 Structure for getting the response from the network after paying the product
 */

struct OrderPaymentResponse: Codable {
    let result: Int
    let userMessage: String
}
