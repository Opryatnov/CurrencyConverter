//
//  NVActivityIndicatorViewable + BankPro.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 5/5/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public protocol IndicatorViewVeble {}

public class Indicator {
    
    public static let sharedInstance = Indicator()
    var indicator = UIActivityIndicatorView()
    let blurImg = AnimationView(name: "Pro_Loader")
    let screenView = UIView()
    
    private init()
    {
        screenView.frame = UIScreen.main.bounds
//        blurImg.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 80, y: UIScreen.main.bounds.height / 2 - 80, width: 160, height: 160)
        blurImg.frame = CGRect(x: screenView.bounds.width / 2 - 80, y: screenView.bounds.height / 2 - 80, width: 160, height: 160)
        blurImg.alpha = 1
        indicator.center = blurImg.center
        blurImg.loopMode = .loop
    }
    
    func showIndicator(){
        DispatchQueue.main.async( execute: {
            UIApplication.shared.keyWindow?.addSubview(self.screenView)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            self.blurImg.play()
        })
    }
    func hideIndicator(){
        
        DispatchQueue.main.async( execute:
            {
                self.blurImg.stop()
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
                self.screenView.removeFromSuperview()
        })
    }
}
