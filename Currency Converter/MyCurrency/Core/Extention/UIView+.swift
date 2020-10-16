//
//  UIView+.swift
//  Fx_Invest
//
//  Created by Dimon on 3/26/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import UIKit

// MARK: - xib
extension UIView {
    
    func fitToSelf(childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["childView": childView]
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat : "H:|[childView]|",
                options          : [],
                metrics          : nil,
                views            : bindings
        ))
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat : "V:|[childView]|",
                options          : [],
                metrics          : nil,
                views            : bindings
        ))
    }
}
