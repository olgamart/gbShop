//
//  ReviewsListRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating review list request to the network
*/

struct ReviewsListRequest: RequestRouter {
    let baseUrl: URL
    let idProduct: Int

    let method: HTTPMethod = .get
    let path: String = "reviewsList"
    var parameters: Parameters? {
        return [
            "id_product": idProduct
        ]
    }
}
