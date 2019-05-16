//
//  SCAPIManager.swift
//  SCTrade
//
//  Created by Mark on 16/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation

enum WebProtocol: String {
    case http   = "http"
    case https  = "https"
}

// can use  MARCO to get different value
// e.g. #ifdef DEV, TESTING, PRODUCTION
let DOMAIN_URL = "www.freeforexapi.com/"

enum EndPoint: String {
    case live = "api/live"
}

class SCAPIManager {
    static let shared = SCAPIManager()
    
    func getAPIUrl(webProtocol: WebProtocol,
                   domain: String,
                   endPoint: EndPoint) -> String {
        
        return webProtocol.rawValue + "://" + domain + endPoint.rawValue
    }
}
