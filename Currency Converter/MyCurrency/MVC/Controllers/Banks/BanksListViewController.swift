//
//  BanksListViewController.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 6/3/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class BanksListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheme()
    }
}

extension BanksListViewController: ThemeProtocol {
    func configureTheme() {
        self.view.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
