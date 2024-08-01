//
//  CurrencyDetailsViewController.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 26.07.24.
//

import UIKit
import Combine

final class CurrencyDetailsViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 15
        static let tableViewContentInset: CGFloat = 20
    }
    
    // MARK: UI
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor(resource: .darkGray6)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude))
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNormalMagnitude, height: CGFloat.leastNormalMagnitude))
        
        return tableView
    }()
    
    // MARK: Private properties
    
    private var currencies: [CurrencyData]?
    private let userDefaultsManager = UserDefaultsManager.shared
    private var currencyType: CurrencyType = .currencyDetails
    private var cancellables = Set<AnyCancellable>()
    private var startDate: String? {
        let dateFormatter = DateFormatter()
        let daysCount: Int = 6
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let previousDate = Calendar.current.date(byAdding: .day, value: -daysCount, to: Date()) else {
            return nil
        }
        
        return dateFormatter.string(from: previousDate)
    }
    
    private var endDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset((self.tabBarController?.tabBar.frame.height ?? .zero) + Constants.tableViewAdditionalInset)
        }
        tableView.contentInset.bottom = Constants.tableViewContentInset
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        cancellables.removeAll()
        reactToFetchCurrencies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBar()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Private methods
    
    private func configureNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = LS("CURRENCIES.TAB.TITLE")
    }
    
    private func reactToFetchCurrencies() {
        NetworkService.shared.$fetchedCurrencies
            .sink { currenciesList in
                self.currencies = currenciesList
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func showError(message: String?) {
        let closeAction = [
            UIAlertAction(title: LS("ALERT.CLOSE.BUTTON"), style: .cancel)
        ]
        showAlert(message: message, buttons: closeAction, viewController: self)
    }
    
    private func fetchRates(_ currencyModel: CurrencyData?) {
        guard let endDate = endDate,
              let startDate = startDate,
              let currencyCode = currencyModel?.currencyID  else { return }
        
        NetworkService.shared.getCurrencyRates(
            networkProvider: NetworkRequestProviderImpl(),
            currencyCode: currencyCode,
            startDate: startDate,
            endDate: endDate
        ) { result in
            switch result {
            case .success:
                let selectedCurrencyViewController = SelectedCurrencyDetailsViewController(nibName: nil, bundle: nil, selectedCurrencyModel: currencyModel)
                selectedCurrencyViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(selectedCurrencyViewController, animated: true)
            case .failure:
                self.showError(message: LS("SORRY.SOME.MISTAKE"))
            }
        }
    }
}

// MARK: - UITableViewDelegate, - UITableViewDataSource

extension CurrencyDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell
        cell?.selectionStyle = .none
        if let currency = currencies?[indexPath.row] {
            cell?.fill(currency: currency, currencyType: currencyType)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard currencyType == .currencyDetails else { return }
        if let currencyModel = currencies?[indexPath.row], currencyModel.currencyAbbreviation != "BYN" {
            fetchRates(currencyModel)
        } else {
            showError(message: LS("SELECTED.CURRENCY.BYN.ANALYTICS.ATTENTION"))
        }
    }
}
