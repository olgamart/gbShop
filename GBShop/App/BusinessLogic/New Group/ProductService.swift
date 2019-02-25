//
//  ProductService.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for getting one product
*/

protocol ProductService {
    /// Get one product
    ///
    /// - Parameters:
    ///   - idProduct: Product Id
    func getProduct(idProduct: Int, completion: @escaping (ProductResponse?) -> Void)
}

class ProductServiceImpl: ProductService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func getProduct(idProduct: Int, completion: @escaping (ProductResponse?) -> Void) {
        let request = ProductRequest(baseUrl: baseUrl, idProduct: idProduct)
        networkService.reqest(request) { (response: ProductResponse?) in
            completion(response)
        }
    }
}
