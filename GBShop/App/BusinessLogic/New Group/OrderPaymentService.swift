//
//  OrderPaymentService.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
/*
 This class sends request to the server to pay the order
*/

protocol OrderPaymentService {
    /// Pay the order
    ///
    /// - Parameters:
    ///   - idOrder: Id of the order
    func orderPayment(idOrder: Int, completion: @escaping (String?) -> Void)
}

class OrderPaymentServiceImpl: OrderPaymentService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func orderPayment(idOrder: Int, completion: @escaping (String?) -> Void) {
        let request = OrderPaymentRequest(baseUrl: baseUrl, idOrder: idOrder)
        networkService.reqest(request) { (response: OrderPaymentResponse?) in
            completion(response?.userMessage)
        }
    }
}
