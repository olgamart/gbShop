//
//  AppDelegate.swift
//  GBShop
//
//  Created by Olga Martyanova on 14/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import UIKit
import YandexMobileMetrica

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Realisation fabric of the objects for network requets without Di.containers
    /*
     let authService = NetworkServiceFactory.shared.makeAuthService()
     let exitService = NetworkServiceFactory.shared.makeExitService()
     let registerService = NetworkServiceFactory.shared.makeRegisterService()
     let changeUserDataService = NetworkServiceFactory.shared.makeChangeUserDataService()
     let productSevice = NetworkServiceFactory.shared.makeProductService()
     let productsListSevice = NetworkServiceFactory.shared.makeProductsListService()
     let reviewService = NetworkServiceFactory.shared.makeReviewService()
     let removeReviewService = NetworkServiceFactory.shared.makeRemoveReviewService()
     let reviewsListService = NetworkServiceFactory.shared.makeReviewsListService()
     let addProductService = NetworkServiceFactory.shared.makeAddProductService()
     let deleteProductService = NetworkServiceFactory.shared.makeDeleteProductService()
     let orderPaymentService = NetworkServiceFactory.shared.makeOrderPaymentService()
     */
    
    let exitService =  Di.container.resolve(ExitService.self)
    let removeReviewService = Di.container.resolve(RemoveReviewService.self)
    let metricaActivator = Di.container.resolve(MetricaActivator.self)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        metricaActivator?.activate()
        Log.log(event: "APPLICATION_START", category: Log.application)
        
        let controller: UIViewController
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(LoginViewController.self)
        window = UIWindow()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        exitService?.logout(id: 123) { result in
            if result == 1 {
                print("Bye!")
            }
        }
        
        removeReviewService?.removeReview(idComment: 123) { result in
            if result == 1 {
                print("Отзыв был успешно удален!")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Log.log(event: "APPLICATION_DID_ENTER_BACKGROUND", category: Log.application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        Log.log(event: "APPLICATION_WILL_ENTER_FOREGROUND", category: Log.application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}
