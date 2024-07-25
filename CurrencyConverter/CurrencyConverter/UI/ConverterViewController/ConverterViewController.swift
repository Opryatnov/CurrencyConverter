//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit
import SnapKit

final class ConverterViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 15
        static let tableViewContentInset: CGFloat = 20
    }
    
    // MARK: UI
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor(resource: .darkGray6)
        
        return tableView
    }()
    
    private var currencies: [CurrencyData]?
    private let userDefaultsManager = UserDefaultsManager.shared
    private var favoriteCurrenciesCode: [Int]? {
        userDefaultsManager.getFavoriteCurrenciesCode()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        view.addSubview(tableView)
        configureNavigationBar()
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.tableViewBottomInset)
            $0.bottom.equalToSuperview().inset((self.tabBarController?.tabBar.frame.height ?? .zero) + Constants.tableViewAdditionalInset)
        }
        tableView.contentInset.bottom = Constants.tableViewContentInset
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyConverterTableviewCell.self, forCellReuseIdentifier: CurrencyConverterTableviewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            let belarusCurrency: CurrencyData = CurrencyData(
                currencyID: 0,
                date: nil,
                currencyAbbreviation: "BYN",
                currencyScale: 1,
                currencyName: "BYN",
                currencyOfficialRate: 0,
                currencyImage: CountriesManager.countries?.countries?.first(where: {$0.code == "BYN"})?.decodedImage,
                isSelected: false,
                name: "Belarusian Ruble",
                nameBelarusian: "Belarusian Ruble",
                nameEnglish: "Belarusian Ruble",
                writeOfAmount: 0
            )
        
        currencies = []
        currencies?.append(belarusCurrency)
        self.favoriteCurrenciesCode?.forEach { code in
            if let favoriteCurrency = NetworkService.shared.allCurrencies?.first(where: { $0.currencyID == code}) {
                if self.currencies?.contains(favoriteCurrency) == false {
                    self.currencies?.append(favoriteCurrency)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = LS("CONVERTER.TAB.TITLE")
    }
}

// MARK: - UITableViewDelegate, - UITableViewDataSource

extension ConverterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyConverterTableviewCell.identifier, for: indexPath) as? CurrencyConverterTableviewCell
        cell?.delegate = self
        cell?.selectionStyle = .none
        if let currency = currencies?[indexPath.row] {
            cell?.fill(currency: currency)
        }
        return cell ?? UITableViewCell()
    }
}

extension ConverterViewController: CurrencyDataModelDelegate {
    func didChangeAmount(currency: CurrencyData?) {
        var bynWriteOfAmount: Double = 0
        if currency?.currencyAbbreviation != "BYN" {
            if let writeOfAmount = currency?.writeOfAmount, let currencyOfficialRate = currency?.currencyOfficialRate {
                bynWriteOfAmount = currencyOfficialRate * writeOfAmount
                currencies?.first(where: {$0.currencyAbbreviation == "BYN"})?.writeOfAmount = bynWriteOfAmount
            }
            currencies?.enumerated().forEach { (index, currencyModel) in
                guard currencyModel.currencyAbbreviation != currency?.currencyAbbreviation,
                      let writeOfAmount = currency?.writeOfAmount,
                      let currencyOfficialRate = currencyModel.currencyOfficialRate,
                      let scale = currencyModel.currencyScale else { return }
                if currencyModel.currencyAbbreviation != "BYN" {
                    let result = bynWriteOfAmount / currencyOfficialRate * Double(scale)
                    currencyModel.writeOfAmount = result
                }
                tableView.beginUpdates()
                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.endUpdates()
            }
        }
    }
}
