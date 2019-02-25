//
//  ErrorParser.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

enum AppError: Error {
    case serverError
    case undefened
}

/*
Class for parsing errors from the network
*/

protocol ErrorParser {
    func parse(_ result: Error) -> AppError
    func parse(_ reauest: URLRequest?, _ response: HTTPURLResponse, _ data: Data?) -> Request.ValidationResult
}

class ErrorParserImpl: ErrorParser {

    func parse(_ result: Error) -> AppError {
        if result is DecodingError {
            return .serverError
        }
        return .undefened
    }

    func parse(_ reauest: URLRequest?, _ response: HTTPURLResponse, _ data: Data?) -> Request.ValidationResult {
        if !(200..<300).contains(response.statusCode) {
            return .failure(AppError.serverError)
        } else if data == nil {
            return .failure(AppError.serverError)
        } else {
            return .success
        }
    }
}
