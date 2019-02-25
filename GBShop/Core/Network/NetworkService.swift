//
//  NetworkService.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

/*
 This class creates network session and response data
*/

protocol NetworkService {
    
    func reqest<T: Decodable>(
        _ request: URLRequestConvertible,
        completionHandler: @escaping (T?) -> Void)
    
}

class NetworkServiceImpl: NetworkService {
    
    let errorParcer: ErrorParser
    let sessionManager: SessionManager
    
    init(
        errorParcer: ErrorParser,
        sessionManager: SessionManager) {
        
        self.errorParcer = errorParcer
        self.sessionManager = sessionManager
    }
    
    func reqest<T: Decodable>(
        _ request: URLRequestConvertible,
        completionHandler: @escaping (T?) -> Void) {
        
        sessionManager
            .request(request)
            .validate(errorParcer.parse).responseData(queue: DispatchQueue.global()) { resрonse in
                let error = resрonse.error as NSError?
                
                if let error = error {
                    switch error.code {
                    case 400...499: print("Client error. Error code: \(error.code)")
                        return
                    case 500...599: print("Server error. Error code: \(error.code)")
                        return
                    default:
                        print("Unknown error. Error code: \(error.code)")
                        DispatchQueue.main.async {
                            completionHandler(nil)
                        }
                        return
                        }
                }
                                
                do {
                    
                    let value = try JSONDecoder().decode(T.self, from: resрonse.result.value!)
                    DispatchQueue.main.async {
                        completionHandler(value)
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completionHandler(nil)
                   }
                }
        }
    }
}
