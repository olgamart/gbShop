//
//  RemoveReviewService.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for the removing review
*/

protocol RemoveReviewService {
    /// Remove review
    ///
    /// - Parameters:
    ///   - idComment: Id of the comment
    func removeReview(idComment: Int, completion: @escaping (Int?) -> Void)
}

class RemoveReviewServiceImpl: RemoveReviewService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func removeReview(idComment: Int, completion: @escaping (Int?) -> Void) {
        let request = RemoveReviewRequest(baseUrl: baseUrl, idComment: idComment)
        networkService.reqest(request) { (response: RemoveReviewResponse?) in
            completion(response?.result)
        }
    }
}
