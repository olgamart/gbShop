//
//  User.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

 /*
 Description оf the entity User for registration and changing data requests, and authorization response
 */

struct User: Codable {
    var id: Int?
    var login: String?
    var name: String?
    var lastname: String?
    var username: String?
    var password: String?
    var email: String?
    var gender: String?
    var creditCard: String?
    var bio: String?

    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
        case username = "username"
        case password = "password"
        case email = "email"
        case gender = "gender"
        case creditCard = "credit_card"
        case bio = "bio"
    }
}
