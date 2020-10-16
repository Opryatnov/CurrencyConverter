//
//  ConverterViewController.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 6/1/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var currencyList: [CurrencyList]?
    var currencyListFromDefaults: [CurrencyList] = []
    let userManager = UserDataManager.shared
    var choosedCurrencyScale: Double = 0
    var choosedCurrencyRate: Double = 0
    var currencyAbbreviation: String = ""
    var currencRate: CurrencyList?
    var currencyValueTextField: UITextField!
    var tempIndexPath: [IndexPath] = []
    var currentIndex = IndexPath()
    var newIndexPAth: [IndexPath] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencyList()
        configureTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Конвертер валют"
        if currencyListFromDefaults.count == 0 {
            tableView.isUserInteractionEnabled = false
        } else {
            tableView.isUserInteractionEnabled = true
        }
    }
    
    private func getCurrencyList() {
        guard let placeData = defaults.object(forKey: "currencyArray") as? Data else { return }
        guard let place = try? PropertyListDecoder().decode([CurrencyList].self, from: placeData) else { return }
        currencyListFromDefaults = place
        tableView.reloadData()
    }
    
    @IBAction func addCurrencyButton(_ sender: UIBarButtonItem) {
        addButtonTapped()
    }
    
    private func updateCell() {
        for (index, valueIndex) in tempIndexPath.enumerated() {
            if valueIndex != currentIndex {
                guard let cell = tableView.cellForRow(at: valueIndex) as? ConvertTableViewCell else { return }
                cell.currencyValueTextField.text = currencyListFromDefaults[index].tempResult
            }
        }
    }
    
     private func addButtonTapped() {
        print("Tapped")
        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: CountryViewController.self)) as! CountryViewController
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewController.newChoosedCountry = currencyListFromDefaults
        viewController.delegare = self
    }
    
    private func calculate(value: String) {
        for currency in currencyListFromDefaults {
            if currency.currencyAbbreviation != currencyAbbreviation {
                guard let tempValue = value.toDouble() else { return }
                currency.enteredValue = tempValue
                let sum = tempValue * Double(currency.currencyScale!) * choosedCurrencyRate / (choosedCurrencyScale * currency.currencyRate!)
                currency.tempResult = String(sum.rounded(toPlaces: 4))
            }
        }
        updateCell()
    }
    
    private func clearCell() {
        for index in tempIndexPath {
            if index != currentIndex {
                guard let cell = tableView.cellForRow(at: index) as? ConvertTableViewCell else { return }
                
                cell.currencyValueTextField.text = nil
                cell.currencyValueTextField.placeholder = "0.00"
                
            }
        }
    }
}

extension ConverterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currencyListFromDefaults.count != 0 {
            return currencyListFromDefaults.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConvertTableViewCell.self), for: indexPath) as! ConvertTableViewCell
        if currencyListFromDefaults.count != 0 {
           cell.configureCell(currency: currencyListFromDefaults[indexPath.row])
            tempIndexPath.append(indexPath)
        } else {
            cell.configureCell(emptyArray: "Выберите валюту")
        }
        cell.delegate = self
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let scale = currencyListFromDefaults[indexPath.row].currencyScale,
            let rate = currencyListFromDefaults[indexPath.row].currencyRate,
            let value = currencyListFromDefaults[indexPath.row].currencyAbbreviation else { return }
        choosedCurrencyScale = Double(scale)
        choosedCurrencyRate = rate
        currencyAbbreviation = value
        currentIndex = indexPath
        clearCell()
    }
}

extension ConverterViewController: ChooseCurrencyDelegate {
    func choosedCurrency(currency: [CurrencyList]) {
       currencyListFromDefaults = currency
        self.tabBarController?.tabBar.isHidden = false
        tempIndexPath = []
        tableView.reloadData()
    }
}

extension ConverterViewController: CalculateDelegate {
    func calculateCurrency(value: String) {
        calculate(value: value)
    }
}

extension ConverterViewController: ThemeProtocol {
    func configureTheme() {
        view.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
