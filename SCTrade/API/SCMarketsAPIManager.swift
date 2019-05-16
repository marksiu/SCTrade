//
//  SCMarketsAPIManager.swift
//  SCTrade
//
//  Created by Mark on 16/5/2019.
//  Copyright © 2019 marksiu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SCMarketsAPIManager {
    static let shared = SCMarketsAPIManager()
    
    let globalBgQueue = DispatchQueue.global(qos: .background)
    
    func getAllCurrencyPair(completionHandler: @escaping (Error?, [String]) -> ()) {
        
        let url = SCAPIManager.shared.getAPIUrl(webProtocol: .https,
                                                domain: DOMAIN_URL,
                                                endPoint: .live)
        
        Alamofire
            .request(url,
                     method: .get,
                     encoding: URLEncoding.default)
            .responseJSON(queue: globalBgQueue) {
                response in
                
                switch response.result {
                case .success(let json):
                    
                    let usdCurrency: String = "USD"
                    var filteredCurrencyPair: [String] = []
                    let currencyPairJson = JSON(json)
                    if let currencyPairArr = currencyPairJson["supportedPairs"].array {
                        for pair in currencyPairArr {
                            let pairStr = pair.stringValue
                            if pairStr.count == 6 {
                                let baseCurrency = pairStr.prefix(3)
                                let quoteCurrency = pairStr.suffix(3)
                                
                                if (baseCurrency == usdCurrency || quoteCurrency == usdCurrency) {
                                    filteredCurrencyPair.append(pairStr)
                                } else {
                                    print(pairStr)
                                }
                            }
                        }
                    }
                    
                    completionHandler(nil, filteredCurrencyPair)
                    
                case .failure(let error):
                    completionHandler(error, [])
                    
                }
                
        }
    }
    
    func getCurrencyPrice(currencyPair: [String],
                          completionHandler: @escaping (Error?, [SCCurrencyPairPrice]) -> ()) {
        
        let url = SCAPIManager.shared.getAPIUrl(webProtocol: .https,
                                                domain: DOMAIN_URL,
                                                endPoint: .live)
        
        let currencyPairStr = currencyPair.joined(separator:",")
        let parameters: Parameters = ["pairs": currencyPairStr]
        
        Alamofire
            .request(url,
                     method: .get,
                     parameters: parameters,
                     encoding: URLEncoding.default)
            .responseJSON(queue: globalBgQueue) {
                response in
                
                switch response.result {
                case .success(let json):
                    
                    let randomNumber = Double(CGFloat(Float(arc4random()) / Float(UINT32_MAX))/1000)  // between 0-1 and /1000 for pip
                    let currencyPriceJson = JSON(json)
                    var currencyPairPriceArr: [SCCurrencyPairPrice] = []
                    if let ratesDict = currencyPriceJson["rates"].dictionary {
                        
                        for (currencyPair, dict) in ratesDict {
                            var currencyPairPrice = SCCurrencyPairPrice()
                            currencyPairPrice.currencyPair = currencyPair
                            currencyPairPrice.source = "Forex"   // hardcoded
                            currencyPairPrice.buyPrice = dict["rate"].doubleValue + randomNumber
                            currencyPairPrice.sellPrice = dict["rate"].doubleValue - randomNumber
                            
                            currencyPairPriceArr.append(currencyPairPrice)
                        }
                        
                    }
                    
                    completionHandler(nil, currencyPairPriceArr)
                    
                case .failure(let error):
                    completionHandler(error, [])
                }
        }
    }
}
