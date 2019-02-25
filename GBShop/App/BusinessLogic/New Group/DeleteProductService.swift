//
//  DeleteProductService.swift
//  GBShop
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
/*
 This class sends request to the server to delete the product from the bucket
*/

protocol DeleteProductService {
    /// Delete product from the bucket
    ///
    /// - Parameters:
    ///   - idProduct: Id of the product
    func deleteProduct(idProduct: Int, completion: @escaping (Int?) -> Void)
}

class DeleteProductServiceImpl: DeleteProductService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func deleteProduct(idProduct: Int, completion: @escaping (Int?) -> Void) {
        let request = DeleteProductRequest(baseUrl: baseUrl, idProduct: idProduct)
        networkService.reqest(request) { (response: DeleteProductResponse?) in
            completion(response?.result)
        }
    }
}
