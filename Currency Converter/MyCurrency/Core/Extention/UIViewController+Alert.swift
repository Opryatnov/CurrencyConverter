//
//  UIViewController+Ginger.swift
//  Ginger
//
//  Created by Dzionis on 1/21/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import UIKit
//
//extension UIViewController {
//    
//    func alert(message: String, title: String? = "Error", buttonTitle: String = "OK", successAction: (() -> Void)? = nil) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
//            successAction?()
//        }
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//    
//    func showCustomError(error: Error, title: String = "Error", buttonTitle: String = "OK", action: (() -> Void)? = nil, successAction: (() -> Void)? = nil) {
//        if let error = error as? BankproError {
//            let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MessageErrorViewController.self)) as! MessageErrorViewController
//            viewController.error = error
//            viewController.requestAction = action ?? {}
//            viewController.delegate = self
//            viewController.modalTransitionStyle = .coverVertical
//            viewController.modalPresentationStyle = .overFullScreen
//            self.present(viewController, animated: true, completion: nil)
//        }
//    }
//}
//  
//
//extension UIViewController: MessageErrorViewControllerDelegate  {
//    func pressButtonTopUp() {
//        self.tabBarController?.selectedIndex = 0
//        self.navigationController?.popToRootViewController(animated: true)
//    }
//    func pressButtonTryAgain( action: (() -> Void)? = nil) {
//        if let action = action {
//            action()
//        }
//    }
//}
// 
//public enum ErrorScreenType {
//    case internetConnectionError
//    case connectiontTimedOutError
//    case workingTowardsCreatingError
//    case unknownError
//    case insufficientBalanceError
//}
