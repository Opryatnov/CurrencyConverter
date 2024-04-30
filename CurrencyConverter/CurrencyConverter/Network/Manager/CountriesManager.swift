//
//  CountriesManager.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 29.04.24.
//

import Foundation

final class CountriesManager {
    static func fetchAllCountries(completion: @escaping (Countries?) -> Void) {
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jList = try JSONDecoder().decode([CountryModel].self, from: data)
                let countries = Countries(countries: jList)
                DispatchQueue.main.async {
                    completion(countries)
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
}
