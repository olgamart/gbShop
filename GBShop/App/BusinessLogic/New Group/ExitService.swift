//
//  ExitService.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends logouting request to the server
*/

protocol ExitService {
    /// Logout user
    ///
    /// - Parameters:
    ///   - id: User Id
    func logout(id: Int, completion: @escaping (Int?) -> Void)
}

class ExitServiceImpl: ExitService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func logout(id: Int, completion: @escaping (Int?) -> Void) {
        let request = LogoutRequest(baseUrl: baseUrl, id: id)
        networkService.reqest(request) { (response: LogoutResponse?) in
            completion(response?.result)
        }
    }
}
