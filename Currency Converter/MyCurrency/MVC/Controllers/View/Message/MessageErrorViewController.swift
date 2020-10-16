//
//  MessageErrorViewController.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit
import SwiftTheme

protocol MessageErrorViewControllerDelegate: class {
    func pressButtonTopUp()
    func pressButtonTryAgain(action: (() -> Void)?)
}

class MessageErrorViewController: UIViewController {
    
    @IBOutlet weak var contanerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    
    private var errorContainerView = ErrorMessageView()
    private var buttonsContainerView = ButtonErrorMessageView()
    var errorScreenType: ErrorScreenType = .unknownError
    var error: Error?
    var requestAction: () -> Void = {}
    
    weak var delegate: MessageErrorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure(errorScreenType: errorScreenType, error: error )
    }
    
    private func configure(errorScreenType: ErrorScreenType, error: Error? = nil) {
        errorContainerView = ErrorMessageView.configureView(errorType: errorScreenType, error: error)
        contanerView.addSubview(errorContainerView)
        errorContainerView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self.contanerView)
        }
        buttonsContainerView = ButtonErrorMessageView.configureView(errorType: errorScreenType)
        buttonsContainerView.delegate = self
        buttonContainerView.addSubview(buttonsContainerView)
        buttonsContainerView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self.buttonContainerView)
        }
    }
    
    private func showAccount() {
        self.delegate?.pressButtonTopUp()
    }
}

extension MessageErrorViewController: ButtonsDelegate {
    func cancelButtonPressed() {
        print("!!cancelButtonPressed!!!!")
        self.dismiss(animated: true, completion: nil)
    }
    
    func settingButtonPressed() {
        print("!!!settingButtonPressed!!")
        self.dismiss(animated: true) {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func topUpButtonPressed() {
        print("!!!topUpButtonPressed!!")
        self.dismiss(animated: true) {
            self.showAccount()
        }
    }
    
    
    func okButtonPressed() {
        print("!!okButtonPressed!!!!")
        self.dismiss(animated: true, completion: nil)
    }
    
    func tryAgainButtonPressed() {
        print("!!tryAgainButtonPressed!!!")
        dismiss(animated: true) {
        self.delegate?.pressButtonTryAgain(action: self.requestAction)
        }
    }
}

extension MessageErrorViewController: ThemeProtocol {
    func configureTheme() {
        self.view.theme_backgroundColor = ColorElement.themeGoldBackground
        buttonsContainerView.theme_backgroundColor = ColorElement.themeGoldBackground
        errorContainerView.theme_backgroundColor = ColorElement.themeGoldBackground
    }
}
