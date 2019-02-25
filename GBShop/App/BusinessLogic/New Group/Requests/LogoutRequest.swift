//
//  LogoutRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating logout request to the network
*/

struct LogoutRequest: RequestRouter {
    let baseUrl: URL
    let id: Int

    let method: HTTPMethod = .get
    let path: String = "logout"
    var parameters: Parameters? {
        return [
            "id_user": id
        ]
    }
}
