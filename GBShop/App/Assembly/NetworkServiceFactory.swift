//
//  NetworkServiceFactory.swift
//  GBShop
//
//  Created by Olga Martyanova on 17/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire

/*
This class creates objects for network requets
*/

class NetworkServiceFactory {

    static let shared = NetworkServiceFactory()
    private init() {}

    let configuration = Configuration()
    let errorParser = ErrorParserImpl()

    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()

    lazy var networkService = NetworkServiceImpl(
        errorParcer: errorParser,
        sessionManager: commonSessionManager
    )

    func makeAuthService() -> AuthService {
        return AuthServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeExitService() -> ExitService {
        return ExitServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeRegisterService() -> RegisterService {
        return RegisterServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeChangeUserDataService() -> ChangeUserDataService {
        return ChangeUserDataServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeProductService() -> ProductService {
        return ProductServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeProductsListService() -> ProductsListService {
        return ProductsListServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeReviewService() -> ReviewService {
        return ReviewServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeRemoveReviewService() -> RemoveReviewService {
        return RemoveReviewServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeReviewsListService() -> ReviewsListService {
        return ReviewsListServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeAddProductService() -> AddProductService {
        return AddProductServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeDeleteProductService() -> DeleteProductService {
        return DeleteProductServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }

    func makeOrderPaymentService() -> OrderPaymentService {
        return OrderPaymentServiceImpl(baseUrl: configuration.baseUrl, networkService: networkService)
    }
}
