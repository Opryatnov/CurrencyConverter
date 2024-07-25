//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 29.04.24.
//

import UIKit
import SnapKit

final class CurrencyTableViewCell: BaseTableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        enum CurrencyNameLabel {
            static let insets: CGFloat = 5
        }
        
        enum CurrencyCodeLabel {
            static let insets: CGFloat = 5
            static let topInset: CGFloat = 2
            static let bottomInset: CGFloat = 5
        }
        
        enum CurrencyView {
            static let topBottom: CGFloat = 10
            static let leftInset: CGFloat = 5
        }
        
        enum CurrencyImageView {
            static let leftInset: CGFloat = 10
            static let size: CGFloat = 32
        }
        
        enum FavoritesImageView {
            static let rightInset: CGFloat = 10
            static let leftInset: CGFloat = 10
            static let size: CGFloat = 32
        }
        
    }
    
    // MARK: UI
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let currencyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let currencyIconImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let favoriteImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let backView: UIView = {
//        let locations: [CGFloat] = [0.0, 1.0]
//        let colors = [UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 0).cgColor, UIColor(red: 0.04, green: 0.52, blue: 0.89, alpha: 0.16).cgColor] as CFArray
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
//        
//        view.startColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 0).withAlphaComponent(0.3)
//        view.endColor = UIColor(red: 0.04, green: 0.52, blue: 0.89, alpha: 0.16).withAlphaComponent(0.3)
//        
//        view.startLocation = 0.0
//        view.endLocation = 1.0
//        view.layer.cornerRadius = 20
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor(resource: .gold1).cgColor
        
        let view = UIView()
        view.backgroundColor = UIColor(resource: .darkGray5)
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    // MARK: Internal properties
    
    static let identifier: String = "CurrencyTableViewCell"
        
    // MARK: Internal methods
    
    func fill(currency: CurrencyData) {
        currencyIconImageView.image = currency.currencyImage
        currencyNameLabel.text = currency.localisedName
        currencyCodeLabel.text = currency.currencyAbbreviation
        favoriteImageView.image = currency.isSelected ? UIImage(named: "selected") : UIImage(named: "nonSelected")
    }
    
    // MARK: Private methods
    
    override func configureViews() {
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(currencyIconImageView)
        backView.addSubview(currencyView)
        currencyView.addSubview(currencyNameLabel)
        currencyView.addSubview(currencyCodeLabel)
        backView.addSubview(favoriteImageView)
    }
    
    override func setupConstraints() {
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        currencyIconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.CurrencyImageView.size)
            $0.leading.equalToSuperview().inset(Constants.CurrencyImageView.leftInset)
            $0.centerY.equalToSuperview()
        }
        
        currencyView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.CurrencyView.topBottom)
            $0.leading.equalTo(currencyIconImageView.snp.trailing).inset(-Constants.CurrencyView.leftInset)
        }
        
        currencyNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.CurrencyNameLabel.insets)
            $0.top.equalToSuperview()
        }
        
        currencyCodeLabel.snp.makeConstraints {
            $0.top.equalTo(currencyNameLabel.snp.bottom).inset(-Constants.CurrencyCodeLabel.topInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.CurrencyCodeLabel.insets)
            $0.bottom.equalToSuperview().inset(Constants.CurrencyCodeLabel.bottomInset)
        }
        
        favoriteImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.FavoritesImageView.size)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(currencyView.snp.trailing).inset(-Constants.FavoritesImageView.leftInset)
            $0.trailing.equalToSuperview().inset(Constants.FavoritesImageView.rightInset)
        }
    }
}
