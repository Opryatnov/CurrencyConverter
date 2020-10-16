//
//  ThemeManager.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit
import SwiftTheme

protocol ThemeProtocol {
    func configureTheme()
}

enum BankThemes: Int {
    
    case day = 0
    case night = 1
    
    // MARK: -
    
    static var current: BankThemes {
        return BankThemes(rawValue: ThemeManager.currentThemeIndex)!
    }
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: BankThemes) {
        ThemeManager.setTheme(index: theme.rawValue)
    }
    
    // MARK: - Switch Night
    
    static func switchNight(isToNight: Bool) {
        switchTo(theme: isToNight ? .night : .day)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
    
//    static func restoreLastTheme() {
//        switchTo(theme: BankThemes(rawValue: UserDefaults.standard.integer(forKey: ConstantUserDefaults.theme)) ?? .day)
//    }
//
//    static func saveLastTheme() {
//        UserDefaults.standard.set(current.rawValue, forKey: ConstantUserDefaults.theme)
//    }
}
