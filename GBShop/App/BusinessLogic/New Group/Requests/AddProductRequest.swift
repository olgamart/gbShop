//
//  AddProductRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
Structure for the creating request to the network to add product to the bucket
*/

struct AddProductRequest: RequestRouter {
    let baseUrl: URL
    let idProduct: Int
    let quantity: Int

    let method: HTTPMethod = .get
    let path: String = "addToBasket"
    var parameters: Parameters? {
        return [
            "id_product": idProduct,
            "quantity": quantity
        ]
    }
}
