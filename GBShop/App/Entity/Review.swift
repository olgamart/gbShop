//
//  Review.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

/*
 Description оf the entity Review for the responses from the network
*/

struct Review: Codable {
    let idProduct: Int
    let idUser: Int
    let userName: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case idUser = "id_user"
        case userName = "user_name"
        case text = "text"
    }
}
