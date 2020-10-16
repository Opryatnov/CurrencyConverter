//
//  AppDelegate.swift
//  MyCurrency
//
//  Created by Opryatnov Dmitriy on 6/3/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
    
      let userManager = UserDataManager.shared
      var currencyList: [CurrencyList] = []
      var tempCurrencyList: [CurrencyList] = []
      let defaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureUI()
        getCurrencyList()
        return true
    }
    
    private func configureUI() {
//        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().theme_barTintColor = ColorElement.themeGoldTabBarBackground
        UITabBar.appearance().tintColor = .white
        UINavigationBar.appearance().theme_barTintColor = ColorElement.themeGoldTabBarBackground
        
        let titleAttributes = ColorElement.themeGoldTitleMainColor.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
            ]
        }
        UINavigationBar.appearance().theme_titleTextAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
        UINavigationBar.appearance().isTranslucent = false
        //        UINavigationBar.appearance().theme_backgroundColor = ColorElement.themeGoldBackground
        //            UINavigationBar.appearance().shadowImage = UIImage()
        //        UIApplication.shared.theme_setStatusBarStyle([.darkContent, .darkContent], animated: true)
        
        //            UITabBar.appearance().theme_barTintColor = ColorElement.themeGoldTabBarBackground
    }
    
    
       private func getCurrencyList() {
            guard let placeData = defaults.object(forKey: "currencyArray") as? Data else { return }
            guard let place = try? PropertyListDecoder().decode([CurrencyList].self, from: placeData) else { return }
            if place.count == 0 {
                getCurrency()
            }
        }
        
        private func getCurrency() {
                userManager.getCurrencyList { [weak self] (result, error) in
                    guard let strongSelf = self else { return }
                    if let error = error {
    print("error \(error)")
                    }
//                    strongSelf.currencyList = strongSelf.userManager.curencyList
//                    strongSelf.saveChoosedCurrency(currency: strongSelf.currencyList)
                }
            }
        
//        private func saveChoosedCurrency(currency: [CurrencyList]?) {
    //        for tempCurrency in currency {
    //            if tempCurrency.currencyName == "USD" {
    //                tempCurrencyList.append(tempCurrency)
//            if let currency = currency {
//                tempCurrencyList.append(currency.first!)
//            }
    //            }
    //        }
//
//            getCurrenyFirstLaunch(currency: tempCurrencyList)
//        }
//
//        private func getCurrenyFirstLaunch(currency: [CurrencyList]) {
//            defaults.set(try? PropertyListEncoder().encode(currency), forKey: "temp")
//        }

}

