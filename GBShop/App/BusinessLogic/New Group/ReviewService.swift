//
//  ReviewService.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server to add the review
*/

protocol ReviewService {
    /// Add the review
    ///
    /// - Parameters:
    ///   - review: Review
    func addReview(review: Review, completion: @escaping (String?) -> Void)
}

class ReviewServiceImpl: ReviewService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func addReview(review: Review, completion: @escaping (String?) -> Void) {
        let request = ReviewRequest(baseUrl: baseUrl, review: review)
        networkService.reqest(request) { (response: ReviewResponse?) in
            completion(response?.userMessage)
        }
    }
}
