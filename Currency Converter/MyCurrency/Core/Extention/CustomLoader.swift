//
//  CustomLoader.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 5/15/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public protocol ActivityIndicatorPresenter {
    
    /// The activity indicator
    var loader: AnimationView { get }
    var loaderView: UIView { get }
    
    /// Show the activity indicator in the view
    func showLoader()
    
    /// Hide the activity indicator in the view
    func hideLoader()
}


public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showLoader() {
        self.loader.alpha = 1
        self.loader.loopMode = .loop
        self.loader.frame = CGRect(x: 0, y: 0, width: 160, height: 160) //or whatever size you would like
        self.loaderView.frame = UIScreen.main.bounds
        loader.center = CGPoint(x: self.loaderView.bounds.size.width / 2, y: self.loaderView.bounds.size.height / 2 - 80)
        self.loaderView.backgroundColor = .black
        self.loaderView.alpha = 0.6
        self.loaderView.addSubview(self.loader)
        
        self.view.addSubview(self.loaderView)
        self.view.isUserInteractionEnabled = false
        self.loaderView.isUserInteractionEnabled = false
        self.loader.play()
    }
    
    func hideLoader() {
        self.loader.stop()
        self.loader.removeFromSuperview()
        self.loaderView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        self.loaderView.isUserInteractionEnabled = true
    }
}
