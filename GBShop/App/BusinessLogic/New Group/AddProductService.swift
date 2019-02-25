//
//  AddProductService.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
/*
 This class sends request to the server to add the product to the bucket
*/

protocol AddProductService {
    /// Add product to the bucket
    ///
    /// - Parameters:
    ///   - idProduct: Id of the product
    ///   - quantity: quantity
    func addProduct(idProduct: Int, quantity: Int, completion: @escaping (String?) -> Void)
}

class AddProductServiceImpl: AddProductService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func addProduct(idProduct: Int, quantity: Int, completion: @escaping (String?) -> Void) {
        let request = AddProductRequest(baseUrl: baseUrl, idProduct: idProduct, quantity: quantity)
        networkService.reqest(request) { (response: AddProductResponse?) in
            completion(response?.userMessage)
        }
    }
}
