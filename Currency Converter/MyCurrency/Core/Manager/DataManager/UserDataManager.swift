//
//  UserDataManager.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import Foundation
import IPAPI
import ObjectMapper
import Moya

typealias RequestResult = ((AnyObject?, Error?) -> Void)?

class UserDataManager: NSObject {
    
    static let shared = UserDataManager()
    override private init(){}
    
    private var currencyListStorage: [CurrencyList] = []
    
    var curencyList: [CurrencyList] {
        get {
            if currencyListStorage.count == 0 {
                getCurrencyList { [weak self] (countryList, error) in
                    guard let strongSelf = self,
                        strongSelf.currencyListStorage.count > 0 else { return }
                }
            }
            return currencyListStorage
        }
        set {
            currencyListStorage = newValue
        }
    }
    
    private var rawCurrencyList: [CurrencyNbRbModel] = [] {
        didSet {
            var tempCurrencyList: [CurrencyList] = []
            for currency in rawCurrencyList {
                let tempCurrency = CurrencyList(currency: currency)
                tempCurrencyList.append(tempCurrency)
                
            }
            tempCurrencyList = tempCurrencyList.sorted(by: {$0.currencyName! < $1.currencyName!})
            self.curencyList = tempCurrencyList
        }
    }
    
    func getCurrencyList(resultBlock: RequestResult) {
        let request = AuthRequest.getListOfCurrency
        authProvider.request(request) { [weak self] result in
            self?.countryListResult(result: result, resultBlock: resultBlock)
        }
    }
    
    private func countryListResult(result: Result<Moya.Response, MoyaError>, resultBlock: RequestResult) {
        switch result {
        case .success(_):
            do {
                let response = try result.get()
                if response.data.count > 0 {
                    let result = try response.mapNSArray()
                    let currency = Mapper<CurrencyNbRbModel>().mapArray(JSONArray: result as! [[String : Any]])
                    rawCurrencyList = currency
                    resultBlock?(currency as AnyObject, nil)
                }
                else {
                    resultBlock?(nil, nil)
                }
            } catch {
                resultBlock?(nil, error)
            }
        case let .failure(error):
            let bankProError: Error = BankproError.custom(error: error)
            resultBlock?(nil, bankProError)
            
        }
    }
}
