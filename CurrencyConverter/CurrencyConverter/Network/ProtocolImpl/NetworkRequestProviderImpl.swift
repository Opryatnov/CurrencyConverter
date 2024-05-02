//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 29.04.24.
//

import Alamofire
import UIKit
import Foundation

enum NetworkingError: Error {
    case badURL, badRequest, badResponse, invalidData
}

final class NetworkRequestProviderImpl: NetworkRequestProvider {
    func fetchAllCurrencies(completion: @escaping (Result<[CurrencyData]?, Error>) -> ()) {
        AF.request("https://api.nbrb.by/exrates/rates?periodicity=0")
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                let jsonDecoder = JSONDecoder()
                guard let currencies: [CurrencyData] = try? jsonDecoder.decode([CurrencyData].self, from: data) else {
                    completion(.failure(NetworkingError.invalidData))
                    return
                }
                completion(.success(currencies))
            }
    }
}
