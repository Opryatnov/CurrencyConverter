//
//  Navigation.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 14.05.24.
//

import UIKit

final class Navigation {
    
    static var currentController: UIViewController? {
        return UIApplication.topViewController()
    }
}
