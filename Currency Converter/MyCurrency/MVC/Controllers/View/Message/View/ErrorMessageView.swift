//
//  ErrorMessageView.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit
import SwiftTheme

class ErrorMessageView: UIView {
    
    @IBOutlet weak var ErrorImageView: UIImageView!
    @IBOutlet weak var titleMessageLabel: UILabel!
    @IBOutlet weak var subtitleMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }

    class func configureView(errorType: ErrorScreenType, error: Error? = nil) -> ErrorMessageView {
        let exchangeView = UINib(nibName: String(describing: ErrorMessageView.self),
                                 bundle: .main).instantiate(withOwner:self, options: nil).first as! ErrorMessageView
        
            switch errorType {
        case .connectiontTimedOutError:
            let message = "Oops, the connection has timed out.\nPlease try again."
            let image = UIImage(named: "no-wifi")
            exchangeView.setConfirmError(view: exchangeView, messageTitle: message, image: image)
            return exchangeView
        case .internetConnectionError:
            let message = "Oops, no internet connection.\nCheck your internet settings"
            let image = UIImage(named: "no-wifi")
            exchangeView.setConfirmError(view: exchangeView, messageTitle: message, image: image)
            return exchangeView
        case .workingTowardsCreatingError:
            let message = "We are working towards creating\nsomething better. We won’t be long"
            let image = UIImage(named: "error")
            exchangeView.setConfirmError(view: exchangeView, messageTitle: message, image: image)
            return exchangeView
        case .unknownError:
            let message = "An error has occurred"
            let image = UIImage(named: "error")
            exchangeView.setConfirmError(view: exchangeView, messageTitle: message, image: image)
            return exchangeView
        case .insufficientBalanceError:
            let message = error?.localizedDescription
            let image = UIImage(named: "error")
            exchangeView.setConfirmError(view: exchangeView, messageTitle: message, image: image)
            return exchangeView
        }
    }

    private func setConfirmError(view: ErrorMessageView, messageTitle: String? = nil, messageSubtitle: String? = nil, image: UIImage?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.38
        view.titleMessageLabel.text = messageTitle
        view.subtitleMessageLabel.text = messageSubtitle
        view.ErrorImageView.image = image
    }
}

extension ErrorMessageView: ThemeProtocol {
    func configureTheme() {
        self.theme_backgroundColor = ColorElement.themeGoldBackground
    }
}
