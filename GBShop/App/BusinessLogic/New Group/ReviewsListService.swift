//
//  ReviewsListService.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for getting the list of reviews
*/

protocol ReviewsListService {
    /// Get the list of reviews
    ///
    /// - Parameters:
    ///   - pageNumber: Number of the page
    func getReviewsList(idProduct: Int, completion: @escaping ([Review]?) -> Void)
}

class ReviewsListServiceImpl: ReviewsListService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func getReviewsList(idProduct: Int, completion: @escaping ([Review]?) -> Void) {
        let request = ReviewsListRequest(baseUrl: baseUrl, idProduct: idProduct)
        networkService.reqest(request) { (response: [Review]?) in
            completion(response)
        }
    }
}
