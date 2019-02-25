//
//  Metrica.swift
//  GBShop
//
//  Created by Olga Martyanova on 18/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation

typealias MetricaParameters = [AnyHashable: Any]
protocol Metrica {
    func log(event: String)
    func log(event: String, parameters: MetricaParameters?)
}

extension Metrica {
    func log(event: String) {
        log(event: event, parameters: nil)
    }
}
