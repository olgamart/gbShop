//
//  ReviewResponse.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

/*
 Structure for getting the review response from the network
*/

struct ReviewResponse: Codable {
    let result: Int
    let userMessage: String
}
