//
//  ProductRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
/*
Structure for the creating request for getting one product from the network
*/

struct ProductRequest: RequestRouter {
    let baseUrl: URL
    let idProduct: Int

    let method: HTTPMethod = .get
    let path: String = "getGoodById"
    var parameters: Parameters? {
        return [
            "id_product": idProduct
        ]
    }
}
