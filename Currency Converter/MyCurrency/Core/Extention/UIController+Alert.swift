//
//  UIController+Alert.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/22/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(message: String, title: String? = "Error", buttonTitle: String = "OK", successAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            successAction?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //FIXME: -put in different methods
    
    func showCustomError(error: Error, title: String = "Error", buttonTitle: String = "OK", action: (() -> Void)? = nil, successAction: (() -> Void)? = nil) {
        if let error = error as? BankproError {
            switch error {
            case .custom(error: let authorisedError):
                if let errorResponse = authorisedError.response, case errorResponse.statusCode = 401 {
                }
                break
            default:
                break
            }
            
            if let authCode = error.additionalCheckNeed {
            } else if let errorScreenType = error.errorScreen {
                let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MessageErrorViewController.self)) as! MessageErrorViewController
                viewController.error = error
                viewController.requestAction = action ?? {}
                viewController.errorScreenType = errorScreenType
                viewController.delegate = self
                viewController.modalTransitionStyle = .coverVertical
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true, completion: nil)
                self.alert(message: error.localizedDescription, title: title, buttonTitle: buttonTitle, successAction: successAction)
                
            } else {
                let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MessageErrorViewController.self)) as! MessageErrorViewController
                               viewController.error = error
                               viewController.requestAction = action ?? {}
                viewController.errorScreenType = .unknownError
                               viewController.delegate = self
                               viewController.modalTransitionStyle = .coverVertical
                               viewController.modalPresentationStyle = .overFullScreen
                               self.present(viewController, animated: true, completion: nil)
                               self.alert(message: error.localizedDescription, title: title, buttonTitle: buttonTitle, successAction: successAction)
                
//                self.alert(message: error.localizedDescription, title: title, buttonTitle: buttonTitle, successAction: successAction)
            }
        }
        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MessageErrorViewController.self)) as! MessageErrorViewController
                       viewController.error = error
                       viewController.requestAction = action ?? {}
        viewController.errorScreenType = .workingTowardsCreatingError
                       viewController.delegate = self
                       viewController.modalTransitionStyle = .coverVertical
                       viewController.modalPresentationStyle = .overFullScreen
                       self.present(viewController, animated: true, completion: nil)
                       self.alert(message: error.localizedDescription, title: title, buttonTitle: buttonTitle, successAction: successAction)
//        self.alert(message: error.localizedDescription, title: title, buttonTitle: buttonTitle)
    }
    
    func showCustemCheckTransactionError(error: Error, action: (() -> Void)? = nil) {
        if let error = error as? BankproError {
            if let errorScreenType = error.errorScreen {
                let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MessageErrorViewController.self)) as! MessageErrorViewController
                viewController.error = error
                viewController.requestAction = action ?? {}
                viewController.errorScreenType = errorScreenType
                viewController.delegate = self
                viewController.modalTransitionStyle = .coverVertical
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true, completion: nil)
            } else {
                self.alert(message: error.localizedDescription, title: nil, buttonTitle: "Close")
            }
        }
        self.alert(message: error.localizedDescription, title: nil, buttonTitle: "Close")
    }
}

extension UIViewController: MessageErrorViewControllerDelegate  {
    func pressButtonTopUp() {
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    func pressButtonTryAgain( action: (() -> Void)? = nil) {
        if let action = action {
            action()
        }
    }
}
 
public enum ErrorScreenType {
    case internetConnectionError
    case connectiontTimedOutError
    case workingTowardsCreatingError
    case unknownError
    case insufficientBalanceError
}
