//
//  CurrencyViewController.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 6/2/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit
import Lottie

class CurrencyViewController: UIViewController, ActivityIndicatorPresenter {
    
    @IBOutlet weak var tableView: UITableView!
    
    let userManager = UserDataManager.shared
    var currencyList: [CurrencyList] = []
     var sortedCurrencyList = [CurrencyList]()
    
    var loader = AnimationView(name: Configuration.loader)
    var loaderView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkCurrency()
    }
    
    private func checkCurrency() {
        if userManager.curencyList.count == 0 {
            getCurrency()
            
        } else {
            sortedCurrencyList = userManager.curencyList
            tableView.reloadData()
        }
    }
    
    private func getCurrency() {
        showLoader()
        userManager.getCurrencyList { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            strongSelf.hideLoader()
            if let error = error {
                DispatchQueue.main.async {
                    strongSelf.showCustomError(error: error, action: strongSelf.getCurrency)
                }
                return
            }
            strongSelf.sortedCurrencyList = strongSelf.userManager.curencyList
            strongSelf.tableView.reloadData()
        }
    }
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCurrencyList.count
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllCurrencyTableViewCell.self), for: indexPath) as! AllCurrencyTableViewCell
        cell.configureCell(currency: userManager.curencyList[indexPath.row])
        cell.updateConstraintsIfNeeded()
        return cell
    }
}

extension CurrencyViewController: ThemeProtocol {
    func configureTheme() {
        self.view.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
