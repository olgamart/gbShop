//
//  ProductsListRequest.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 Structure for the creating request for getting list ot the products from the network
*/

struct ProductsListRequest: RequestRouter {
    let baseUrl: URL
    let pageNumber: Int
    let idCategory: Int

    let method: HTTPMethod = .get
    let path: String = "catalogData"
    var parameters: Parameters? {
        return [
            "page_number": pageNumber,
            "id_category": idCategory
        ]
    }
}
