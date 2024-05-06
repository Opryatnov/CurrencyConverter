//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
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
        
        return tableView
    }()
    
    // MARK: Private properties
    
    private var currencies: [CurrencyData]?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(Constants.tableViewBottomInset)
            $0.bottom.equalToSuperview().inset((self.tabBarController?.tabBar.frame.height ?? .zero) + Constants.tableViewAdditionalInset)
        }
        tableView.contentInset.bottom = Constants.tableViewContentInset
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrencyList()
    }
    
    // MARK: Private methods
    
    private func fetchCurrencyList() {
        NetworkService.shared.getCurrencyList(networkProvider: NetworkRequestProviderImpl()) { result in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(message: error.localizedDescription, buttons: [], viewController: self)
            }
        }
    }
}

// MARK: - UITableViewDelegate, - UITableViewDataSource

extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell
        cell?.selectionStyle = .none
        if let currency = currencies?[indexPath.row] {
            cell?.fill(currency: currency)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currency = currencies?[indexPath.row] {
            currency.isSelected.toggle()
            tableView.reloadData()
        }
    }
}
