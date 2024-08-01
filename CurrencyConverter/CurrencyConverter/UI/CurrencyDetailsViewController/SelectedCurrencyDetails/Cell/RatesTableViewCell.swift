//
//  RatesTableViewCell.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 1.08.24.
//

import UIKit
import SnapKit

enum RateState {
    case positive
    case negative
    case equal
}

final class RatesTableViewCell: BaseTableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let leftInset: CGFloat = 16
        static let topBottomInsets: CGFloat = 5
        static let rightInset: CGFloat = 16
    }
    
    // MARK: UI
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private let officialRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .darkSecondary6)
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let fuelPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let rateView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(resource: .gold1).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 17
        view.backgroundColor = UIColor(resource: .darkGray5)
        
        return view
    }()
    
    private let stateIconImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    // MARK: Internal properties
    
    static let identifier: String = "RatesTableViewCell"
        
    // MARK: Internal methods
    
    func fill(currencyRate: DynamicCources?, rateState: RateState) {
        guard let currencyRate = currencyRate else { return }
        dateLabel.text = LS("DATE.TITLE") + currencyRate.formattedDate
        officialRateLabel.text = LS("RATE.TITLE") + currencyRate.formattedAmount
        stateIconImageView.image = setupRateIcon(rateState)
    }
    
    // MARK: Override methods
    
    override func configureViews() {
        backgroundColor = .clear
        addSubview(rateView)
        rateView.addSubview(dateLabel)
        rateView.addSubview(officialRateLabel)
        rateView.addSubview(stateIconImageView)
    }
    
    override func setupConstraints() {
        rateView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.topBottomInsets)
            $0.leading.trailing.equalToSuperview().inset(Constants.leftInset)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.leftInset)
            $0.top.equalToSuperview().inset(Constants.topBottomInsets)
        }
        officialRateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.leftInset)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-Constants.topBottomInsets)
            $0.bottom.equalToSuperview().inset(Constants.topBottomInsets)
        }
        stateIconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.rightInset)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: Private methods
    
    private func setupRateIcon(_ rateState: RateState) -> UIImage? {
        switch rateState {
        case .positive:
            return UIImage(resource: .arrowUp30)
        case .negative:
            return UIImage(resource: .arrowDown30)
        case .equal:
            return UIImage(resource: .equalSign30)
        }
    }
}
