//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit
import SnapKit
import Combine
import GoogleMobileAds

final class ConverterViewController: UIViewController, GADBannerViewDelegate {
    
    // MARK: Constants
    
    private enum Constants {
        static let tableViewBottomInset: CGFloat = 20
        static let tableViewAdditionalInset: CGFloat = 5
        static let tableViewContentInset: CGFloat = 61
        static let bynCode: String = "BYN"
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
    private var cancellables = Set<AnyCancellable>()
    
    private var currentFormattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
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
        tableView.register(CurrencyConverterTableviewCell.self, forCellReuseIdentifier: CurrencyConverterTableviewCell.identifier)
        
        bind()
        configureBannerView()
    }
    
    // MARK: Private methods
    
    private func bind() {
        cancellables.removeAll()
        reactToFetchCurrencies()
        subscribeToChangeFavoriteList()
    }
    
    private func configureBannerView() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        view.addSubview(bannerView)
        
        let topInset = UIDevice.hasNotch ? Constants.isHasNoughtHeight : Constants.tableViewAdditionalInset
        bannerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(topInset + 15)
        }
        
        bannerView.adUnitID = AppConstants.googleBannerADKey
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    private func configureCurrencies(_ currenciesList: [CurrencyData]?) {
        self.currencies = []
        self.favoriteCurrenciesCode?.forEach { code in
            if let favoriteCurrency = currenciesList?.first(where: { $0.currencyID == code}) {
                if self.currencies?.contains(favoriteCurrency) == false {
                    self.currencies?.append(favoriteCurrency)
                }
            }
        }
        self.currencies = self.currencies?.sorted(by: {$0.currencyAbbreviation ?? "" < $1.currencyAbbreviation ?? ""})
        self.tableView.reloadData()
    }
    
    
    private func reactToFetchCurrencies() {
        NetworkService.shared.$fetchedCurrencies
            .sink { currenciesList in
                self.configureCurrencies(currenciesList)
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToChangeFavoriteList() {
        UserDefaultsManager.shared.$isChangedFavoriteList
            .sink { isChanged in
                guard isChanged == true else { return }
                self.configureCurrencies(NetworkService.shared.fetchedCurrencies)
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.topItem?.title = LS("CONVERTER.TAB.TITLE") + " " + currentFormattedDate
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
