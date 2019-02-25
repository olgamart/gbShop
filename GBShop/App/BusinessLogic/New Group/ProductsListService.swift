//
//  ProductsListService.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for getting the list of products
*/

protocol ProductsListService {
    /// Get list of the products
    ///
    /// - Parameters:
    ///   - pageNumber: Number of the page
    ///   - idCategory: Id of the category
    func getProductsList(pageNumber: Int, idCategory: Int, completion: @escaping ([Product]?) -> Void)
}

class ProductsListServiceImpl: ProductsListService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func getProductsList(pageNumber: Int, idCategory: Int, completion: @escaping ([Product]?) -> Void) {
        let request = ProductsListRequest(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        networkService.reqest(request) { (response: [Product]?) in
            completion(response)
        }
    }
}
