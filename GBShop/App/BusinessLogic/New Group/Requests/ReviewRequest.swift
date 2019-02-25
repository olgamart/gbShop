//
//  ReviewRequest.swift
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

struct ReviewRequest: RequestRouter {
    let baseUrl: URL
    let review: Review
    
    let method: HTTPMethod = .post
    let path: String = "addReview"
    var parameters: Parameters? {
        return [
            "id_user": review.idUser,
            "text": review.text
        ]
    }
}
