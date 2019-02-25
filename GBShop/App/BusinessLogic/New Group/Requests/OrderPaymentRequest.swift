//
//  OrderPaymentRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating request to the network to pay the order
*/

struct OrderPaymentRequest: RequestRouter {
    let baseUrl: URL
    let idOrder: Int

    let method: HTTPMethod = .post
    let path: String = "orderPayment"
    var parameters: Parameters? {
        return [
            "id_order": idOrder
        ]
    }
}
