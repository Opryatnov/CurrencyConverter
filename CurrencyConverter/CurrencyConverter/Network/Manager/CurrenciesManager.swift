//
//  CurrenciesManager.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 3.05.24.
//

import Foundation

final class CurrenciesManager {
    
    static let shared = CurrenciesManager()
    private init() {}
    
    var allCurrencyData: [FullCurrencyData]? = []
    
    func fetchCurrencies() {
        if let path = Bundle.main.path(forResource: "allCurrenciesWithLanguages", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jList = try JSONDecoder().decode([FullCurrencyData].self, from: data)
                DispatchQueue.main.async {
                    self.allCurrencyData = jList
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                allCurrencyData = nil
            }
        } else {
            print("Invalid filename/path.")
            allCurrencyData = nil
        }
    }
}
