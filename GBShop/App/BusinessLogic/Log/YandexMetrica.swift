//
//  YandexMetrica.swift
//  GBShop
//
//  Created by Olga Martyanova on 18/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import YandexMobileMetrica

struct YandexMetrica: Metrica, MetricaActivator {
    
    func log(event: String, parameters: MetricaParameters?) {
        YMMYandexMetrica.reportEvent(event,
                                     parameters: parameters,
                                     onFailure: { error in
           Log.log(event: error.localizedDescription, category: Log.application)
        })
    }
    
    func activate () {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "e6cae222-dd55-4cca-9472-ca5588bb5af9")
        YMMYandexMetrica.activate(with: configuration!)
    }
}
