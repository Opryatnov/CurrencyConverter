//
//  AppInfoViewController.swift
//  MyCurrency
//
//  Created by Opryatnov Dmitriy on 6/6/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheme()
    }
}

extension AppInfoViewController: ThemeProtocol {
    func configureTheme() {
        self.view.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
