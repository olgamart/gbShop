//
//  RegisterRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating registration request to the network
*/

struct RegisterRequest: RequestRouter {
    let baseUrl: URL
    let userData: User

    let method: HTTPMethod = .post
    let path: String = "registerUser"
    var parameters: Parameters? {
        guard let id = userData.id,
            let username = userData.username,
            let password = userData.password,
            let email = userData.email,
            let gender = userData.gender,
            let creditCard = userData.creditCard,
            let bio = userData.bio
            else {return [:]}
        return [
            "id_user": id,
            "username": username,
            "password": password,
            "email": email,
            "gender": gender,
            "credit_card": creditCard,
            "bio": bio
        ]
    }
}
