//
//  RemoveReviewRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating remove review request to the network
*/

struct RemoveReviewRequest: RequestRouter {
    let baseUrl: URL
    let idComment: Int

    let method: HTTPMethod = .get
    let path: String = "removeReview"
    var parameters: Parameters? {
        return [
            "id_comment": idComment
        ]
    }
}
