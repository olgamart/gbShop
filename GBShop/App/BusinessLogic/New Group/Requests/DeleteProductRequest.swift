//
//  DeleteProductRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating request to the network to delete product from the bucket
 */

struct DeleteProductRequest: RequestRouter {
    let baseUrl: URL
    let idProduct: Int

    let method: HTTPMethod = .get
    let path: String = "deleteFromBasket"
    var parameters: Parameters? {
        return [
            "id_product": idProduct
        ]
    }
}
