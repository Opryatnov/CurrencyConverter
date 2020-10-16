//
//  ButtonErrorMessageView.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

protocol ButtonsDelegate: AnyObject  {
    func okButtonPressed()
    func tryAgainButtonPressed()
    func settingButtonPressed()
    func topUpButtonPressed()
    func cancelButtonPressed()
}

class ButtonErrorMessageView: UIView {
   
    weak var delegate: ButtonsDelegate?
    @IBOutlet weak var settingHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    
    class func configureView(errorType: ErrorScreenType) -> ButtonErrorMessageView {
        
        let buttonErrorMessageView = UINib(nibName: String(describing: ButtonErrorMessageView.self),
                                            bundle: .main).instantiate(withOwner:self, options: nil).first as! ButtonErrorMessageView
        
        switch errorType {
        case .connectiontTimedOutError:
            buttonErrorMessageView.settingHeightConstrain.constant = 0
            buttonErrorMessageView.okButton.setTitle("Try again", for: .normal)
            buttonErrorMessageView.okButton.addTarget(buttonErrorMessageView, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
            return buttonErrorMessageView
            
        case .internetConnectionError:
            buttonErrorMessageView.settingHeightConstrain.constant = 66
            buttonErrorMessageView.okButton.setTitle("Try again", for: .normal)
            buttonErrorMessageView.okButton.addTarget(buttonErrorMessageView, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
            buttonErrorMessageView.settingButton.setTitle("Go to Settings", for: .normal)
            buttonErrorMessageView.settingButton.addTarget(buttonErrorMessageView, action: #selector(settingButtonPressed), for: .touchUpInside)
            return buttonErrorMessageView
            
        case .workingTowardsCreatingError:
            buttonErrorMessageView.okButton.setTitle("Try again", for: .normal)
            buttonErrorMessageView.okButton.addTarget(buttonErrorMessageView, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
            buttonErrorMessageView.settingHeightConstrain.constant = 0
            return buttonErrorMessageView
            
        case .unknownError:
            buttonErrorMessageView.okButton.setTitle("Try again", for: .normal)
            buttonErrorMessageView.okButton.addTarget(buttonErrorMessageView, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
            buttonErrorMessageView.settingHeightConstrain.constant = 0
            return buttonErrorMessageView
            
        case .insufficientBalanceError:
            buttonErrorMessageView.settingHeightConstrain.constant = 66
            buttonErrorMessageView.okButton.setTitle("Go to Accounts", for: .normal)
            buttonErrorMessageView.okButton.addTarget(buttonErrorMessageView, action: #selector(topUpButtonpresseed), for: .touchUpInside)
            buttonErrorMessageView.settingButton.setTitle("Close", for: .normal)
            buttonErrorMessageView.settingButton.addTarget(buttonErrorMessageView, action: #selector(cancelButtonPressed), for: .touchUpInside)
            return buttonErrorMessageView
        }
    }
    
   @objc func tryAgainButtonPressed() {
        delegate?.tryAgainButtonPressed()
    }
    
    
    @objc func settingButtonPressed() {
        delegate?.settingButtonPressed()
    }
    
    @objc func okButtonPressed() {
        delegate?.okButtonPressed()
    }
    
    @objc func topUpButtonpresseed() {
        delegate?.topUpButtonPressed()
    }
    
    @objc func cancelButtonPressed() {
        delegate?.cancelButtonPressed()
    }
}
