//
//  ChangeUserDataService.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
 This class sends request to the server for the changing user data
*/

protocol ChangeUserDataService {
    /// Change user data
    ///
    /// - Parameters:
    ///   - userData: Changed user data
    func changeUserData(userData: User, completion: @escaping (Int?) -> Void)
}

class ChangeUserDataServiceImpl: ChangeUserDataService {

    let baseUrl: URL
    let networkService: NetworkService

    init(
        baseUrl: URL,
        networkService: NetworkService) {

        self.baseUrl = baseUrl
        self.networkService = networkService
    }

    func changeUserData(userData: User, completion: @escaping (Int?) -> Void) {
        let request = ChangeUserDataRequest(baseUrl: baseUrl, userData: userData)
        networkService.reqest(request) { (response: ChangeUserDataResponse?) in
            completion(response?.result)
        }
    }
}
