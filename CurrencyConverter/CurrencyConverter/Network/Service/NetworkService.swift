//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 29.04.24.
//

import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    
    /// Получение курсов валют на текущую дату
    func getCurrencyList(networkProvider: NetworkRequestProvider?, completion: @escaping (Result<[CurrencyData]?, Error>) -> ()) {
        HUD.shared.show()
        networkProvider?.fetchAllCurrencies(completion: { result in
            switch result {
            case .success(let currencies):
                CountriesManager.fetchAllCountries { countries in
                    currencies?.forEach { currency in
                        if let currencyImage = countries?.countries?.first(where: {$0.code == currency.currencyAbbreviation})?.decodedImage {
                            currency.currencyImage = currencyImage
                        } else if currency.currencyAbbreviation == "EUR" {
                            currency.currencyImage = UIImage(named: "European-Union-Flag-icon")
                        } else {
                            currency.currencyImage = UIImage(named: "sdr_image")
                        }
                    }
                    HUD.shared.hide()
                    completion(.success(currencies))
                }
            case .failure(let error):
                HUD.shared.hide()
                completion(.failure(error))
            }
        })
    }
}
// https://api.nbrb.by/bic - https://www.nbrb.by/apihelp/bic
