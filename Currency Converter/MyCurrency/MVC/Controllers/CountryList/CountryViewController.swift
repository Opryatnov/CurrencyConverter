//
//  CountryViewController.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit
import Lottie

protocol ChooseCurrencyDelegate {
    func choosedCurrency(currency: [CurrencyList])
}

class CountryViewController: UIViewController, ActivityIndicatorPresenter {
    
    @IBOutlet weak var tableView: UITableView!
    var returnScreen: AnyClass = ConverterViewController.self
    var delegare: ChooseCurrencyDelegate?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let userManager = UserDataManager.shared
    var currencyList: [CurrencyList] = []
    var tempCurrencyList: [CurrencyList] = []
    let defaults = UserDefaults.standard
    var sortedCurrencyList = [CurrencyList]()
    var newChoosedCountry = [CurrencyList]()
    
    var loader = AnimationView(name: Configuration.loader)
    var loaderView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrency()
        configureNavigationBar()
        configureTheme()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barStyle = .default
        definesPresentationContext = true
        tableView.backgroundView = UIView()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_navigation_back"), style: .done, target: self, action: #selector(popNavigationController))
        title = "Валюта"
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func checkCurrency() {
        if userManager.curencyList.count == 0 {
            getCurrency()
  
        } else {
            currencyList = userManager.curencyList
            getCurrencyList()
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

            strongSelf.currencyList = strongSelf.userManager.curencyList
            if strongSelf.newChoosedCountry.count != 0 {
                strongSelf.getCurrencyList()
            } else {
                strongSelf.sortedCurrencyList = strongSelf.currencyList
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    private func getCurrencyList() {
        
        let searchValue = newChoosedCountry
        for (index, value) in currencyList.enumerated() {
            for searchingValue in searchValue {
                if value.currencyName == searchingValue.currencyName {
                    currencyList[index] = searchingValue
                }
            }
        }
        sortedCurrencyList = currencyList
        tableView.reloadData()
    }
    
    private func saveChoosedCurrency(currency: [CurrencyList]) {
        defaults.removeObject(forKey: "currencyArray")
        for tempCurrency in currency {
            if tempCurrency.isSelected == true {
                tempCurrencyList.append(tempCurrency)
            }
        }
        
        defaults.set(try? PropertyListEncoder().encode(tempCurrencyList), forKey: "currencyArray")
        self.delegare?.choosedCurrency(currency: self.tempCurrencyList)
    }

    
    @objc func popNavigationController() {
        saveChoosedCurrency(currency: sortedCurrencyList)
        
        if let viewController = navigationController?.viewControllers.first(where: { type(of: $0) == returnScreen }) {
            navigationController?.popToViewController(viewController, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}


extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyTableViewCell.self), for: indexPath) as! CurrencyTableViewCell
        cell.configureCell(currencyModel: sortedCurrencyList[indexPath.row])
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sortedCurrencyList[indexPath.row].isSelected == false {
            sortedCurrencyList[indexPath.row].isSelected = true
        } else {
            sortedCurrencyList[indexPath.row].isSelected = false
        }
        tableView.reloadData()
    }
}

extension CountryViewController: UISearchResultsUpdating  {
    func updateSearchResults (for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        searchForText(searchString)
    }

    private func searchForText(_ text: String) {
        if text.isEmpty {
            sortedCurrencyList = currencyList
        } else {
            sortedCurrencyList = currencyList
            sortedCurrencyList = currencyList.filter{ $0.currencyName!.lowercased().hasPrefix(text.lowercased())}
                sortedCurrencyList = sortedCurrencyList.sorted(by: {$0.currencyName! == text || $1.currencyName == text})
        }
        tableView.reloadData()
    }
}

extension CountryViewController: ThemeProtocol {
    func configureTheme() {
        self.view.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
        if #available(iOS 13, *) {
            searchController.searchBar.theme_backgroundColor = ColorElement.themeGoldBackground
            searchController.searchBar.searchTextField.theme_textColor = ColorElement.themeGoldTitleRegular
        }
    }
}
