//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit
import Combine
import GoogleMobileAds


final class CurrencyListViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 5
        static let tableViewContentInset: CGFloat = 61
        static let isHasNoughtHeight: CGFloat = 85
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
    
    private var bannerView: GADBannerView!
    
    // MARK: Private properties
    
    private var currencies: [CurrencyData]?
    private let userDefaultsManager = UserDefaultsManager.shared
    private var favoriteCurrenciesCode: [Int]? {
        userDefaultsManager.getFavoriteCurrenciesCode()
    }
    private var currencyType: CurrencyType = .currencyList
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .darkGray6)
        view.addSubview(tableView)
        configureNavigationBar()
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset((self.tabBarController?.tabBar.frame.height ?? .zero) + Constants.tableViewAdditionalInset)
        }
        tableView.contentInset.bottom = Constants.tableViewContentInset
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        configureBannerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancellables.removeAll()
        reactToFetchCurrencies()
    }
    
    // MARK: Private methods
    
    private func configureBannerView() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        view.addSubview(bannerView)
        
        let topInset = UIDevice.hasNotch ? Constants.isHasNoughtHeight + 15 : (tabBarController?.tabBar.frame.size.height ?? 50) + Constants.tableViewAdditionalInset
        bannerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(topInset)
        }
        
        bannerView.adUnitID = AppConstants.googleBannerADKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    private func reactToFetchCurrencies() {
        NetworkService.shared.$fetchedCurrencies
            .sink { currenciesList in
                self.currencies = currenciesList
                self.favoriteCurrenciesCode?.forEach { code in
                    self.currencies?.first(where: { $0.currencyID == code})?.isSelected = true
                }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = LS("CURRENCY.LIST.TAB.TITLE")
    }
    
    private func showError(message: String?) {
        let closeAction = [
            UIAlertAction(title: LS("ALERT.CLOSE.BUTTON"), style: .cancel)
        ]
        showAlert(message: message, buttons: closeAction, viewController: self)
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
            cell?.fill(currency: currency, currencyType: currencyType)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard currencyType == .currencyList else { return }
        if let currency = currencies?[indexPath.row] {
            currency.isSelected.toggle()
            guard let currencyID = currency.currencyID else { return }
            if currency.isSelected == true {
                userDefaultsManager.setFavoriteCurrenciesCode(currencyID)
            } else {
                userDefaultsManager.removeFavorite(currencyID)
            }
            userDefaultsManager.isChangedFavoriteList = true
            tableView.reloadData()
        }
    }
}
