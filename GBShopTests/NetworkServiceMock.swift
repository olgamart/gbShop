//
//  NetworkServiceMock.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
import Alamofire
@testable import GBShop

class NetworkServiceMock: NetworkService {

    var result: Any?

    func reqest<T>(
        _ request: URLRequestConvertible,
        completionHandler: @escaping (T?) -> Void) where T: Decodable {

        completionHandler(result as? T)
    }

}
