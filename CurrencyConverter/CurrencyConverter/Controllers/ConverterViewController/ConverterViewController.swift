//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit

final class ConverterViewController: UIViewController {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        var textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = LS("CONVERTER.TAB.TITLE")
    }
}
