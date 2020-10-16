//
//  KeyboardManager.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class KeyboardManager: NSObject {

    static let shared = KeyboardManager()
    
    var isOpen = false
    var notification: NSNotification?
    
    override private init(){
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        isOpen = true
        self.notification = notification
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        isOpen = false
        self.notification = notification
    }
}
