//
//  MainTabBarViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 15.03.23.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setTabBarAppearance()

    }
    
    private func setupTabBar() {
        
        viewControllers = [
            setupVieController(
                viewcontroller: ConverterViewController(),
                title: "Converter",
                image: UIImage(named: "settings")
            ),
            setupVieController(
                viewcontroller: CurrencyListViewController(),
                title: "CurrencyList",
                image: UIImage(named: "settings")
            ),
            setupVieController(
                viewcontroller: SettingsViewController(),
                title: "Settings",
                image: UIImage(named: "free-icon-exchange-3879126")
            )
        ]
        
    }
    
    private func setupVieController(
                                    viewcontroller: UIViewController,
                                    title: String,
                                    image: UIImage?) -> UIViewController {
        
        viewcontroller.tabBarItem.title = title
        return viewcontroller
    }
    
    private func setTabBarAppearance() {
        let positionX: CGFloat  = 10
        let positionY: CGFloat  = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let beziePath = UIBezierPath(
            roundedRect: CGRect(
                x: positionY,
                y: tabBar.bounds.minY - positionY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = beziePath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.withAlphaComponent(0.3).cgColor
        
        
        let unselectedColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .selected)
        
        let homeUnselectedImage: UIImage = UIImage(named: "exchange_unselected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let homeSelectedImage: UIImage = UIImage(named: "exchange_selected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let currencyUnselectedImage: UIImage = UIImage(named: "currency_unselected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let currencySelectedImage: UIImage = UIImage(named: "currency_selected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let settingsUnselectedImage: UIImage = UIImage(named: "settings_unselected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let settingsSelectedImage: UIImage = UIImage(named: "settings_selected_icon")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        if let items = tabBar.items {
            items[0].image = homeUnselectedImage
            items[0].selectedImage = homeSelectedImage
            
            items[1].image = currencyUnselectedImage
            items[1].selectedImage = currencySelectedImage
            
            items[2].image = settingsUnselectedImage
            items[2].selectedImage = settingsSelectedImage
        }
    }
}
