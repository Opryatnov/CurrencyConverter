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
        static let bynCode: String = "BYN"
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
        currencies = []
        self.favoriteCurrenciesCode?.forEach { code in
            if let favoriteCurrency = NetworkService.shared.allCurrencies?.first(where: { $0.currencyID == code}) {
                if self.currencies?.contains(favoriteCurrency) == false {
                    self.currencies?.append(favoriteCurrency)
                }
            }
        }
        currencies = currencies?.sorted(by: {$0.currencyAbbreviation ?? "" < $1.currencyAbbreviation ?? ""})
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
        var otherWriteOfAmount: Double = 0
        
        if let writeOfAmount = currency?.writeOfAmount, let currencyOfficialRate = currency?.currencyOfficialRate,
           let currentCurrencyScale = currency?.currencyScale {
            bynWriteOfAmount = currency?.currencyAbbreviation != Constants.bynCode ? (currencyOfficialRate * writeOfAmount) : (currency?.writeOfAmount ?? 0)
            otherWriteOfAmount = currency?.currencyAbbreviation != Constants.bynCode ? (currencyOfficialRate * writeOfAmount) : (currency?.writeOfAmount ?? 0)
            currencies?.first(where: {$0.currencyAbbreviation == Constants.bynCode})?.writeOfAmount = bynWriteOfAmount / Double(currentCurrencyScale)
        }
        currencies?.enumerated().forEach { (index, currencyModel) in
            guard currencyModel.currencyAbbreviation != currency?.currencyAbbreviation,
                  let writeOfAmount = currency?.writeOfAmount,
                  let currencyOfficialRate = currencyModel.currencyOfficialRate,
                  let scale = currencyModel.currencyScale,
                  let currentCurrencyScale = currency?.currencyScale else { return }
            if currencyModel.currencyAbbreviation != Constants.bynCode {
                let result = (otherWriteOfAmount / currencyOfficialRate * Double(scale)) / Double(currentCurrencyScale)
                currencyModel.writeOfAmount = result
            }
            tableView.beginUpdates()
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()
        }
    }
}
