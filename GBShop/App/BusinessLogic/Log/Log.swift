//
//  Log.swift
//  GBShop
//
//  Created by Olga Martyanova on 18/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
import os.log

struct Log {
    
    private static let subsystem = "com.olgamart.GBShop"
    
    #if DEBUG
    static let network = OSLog(subsystem: Log.subsystem, category: "network")
    static let application = OSLog(subsystem: Log.subsystem, category: "application")
    #else
    static let network = OSLog.disabled
    static let application = OSLog.disabled
    #endif    
    
    static func log (event: String, category: OSLog) {
        #if DEBUG
        os_log("%{public}@", log: category, type: .info, event)
        #endif
    }
}
