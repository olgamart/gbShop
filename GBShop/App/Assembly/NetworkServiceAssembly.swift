//
//  NetworkServiceAssembly.swift
//  GBShop
//
//  Created by Olga Martyanova on 21/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import Alamofire
import Swinject

/*
 This class creates objects for network requets via di-containers
*/

class Di {
    private static let assembler = Assembler([
        NetworkServiceAssembly(),
        ApplicationAssembly()
        ])

    static var container: Resolver {
        return assembler.resolver
    }
}

class NetworkServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SessionManager.self) { _ in
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            let manager = SessionManager(configuration: configuration)
            return manager
            }.inObjectScope(.container)

        container.register(NetworkService.self) { resolver in
            return NetworkServiceImpl(
                errorParcer: resolver.resolve(ErrorParser.self)!,
                sessionManager: resolver.resolve(SessionManager.self)!
            )
            }.inObjectScope(.container)

        container.register(AuthService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return AuthServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ExitService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ExitServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(RegisterService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return RegisterServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ChangeUserDataService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ChangeUserDataServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ProductService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ProductServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ProductsListService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ProductsListServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ReviewService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ReviewServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(RemoveReviewService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return RemoveReviewServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(ReviewsListService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return ReviewsListServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(AddProductService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return AddProductServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(DeleteProductService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return DeleteProductServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)

        container.register(OrderPaymentService.self) { resolver in
            let baseUrl = resolver.resolve(Configuration.self)!.baseUrl
            return OrderPaymentServiceImpl(
                baseUrl: baseUrl,
                networkService: resolver.resolve(NetworkService.self)!
            )
            }.inObjectScope(.transient)
        
        container.register(MetricaActivator.self) { _ in
            return YandexMetrica()
            }.inObjectScope(.transient)
        
        container.register(Metrica.self) { _ in
            return YandexMetrica()
            }.inObjectScope(.transient)
    }
    
}

class ApplicationAssembly: Assembly {

    func assemble(container: Container) {

        container.register(Configuration.self) { _ in
            return Configuration()
            }.inObjectScope(.container)

        container.register(ErrorParser.self) { _ in
            return ErrorParserImpl()
            }.inObjectScope(.container)

    }

}
