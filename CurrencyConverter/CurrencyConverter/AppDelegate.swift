//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 15.03.23.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.requestTrackingAuthorization()
        }
        FirebaseApp.configure()
        fetchCurrencies()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: Private methods
    
    private func fetchCurrencies() {
        NetworkService.shared.getCurrencyList(networkProvider: NetworkRequestProviderImpl()) { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    @objc private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Tracking authorization status: Authorized")
                case .denied:
                    print("Tracking authorization status: Denied")
                case .restricted:
                    print("Tracking authorization status: Restricted")
                case .notDetermined:
                    print("Tracking authorization status: Not Determined")
                @unknown default:
                    print("Tracking authorization status: Unknown")
                }
            }
        } else {
            print("Tracking authorization is not available for iOS versions below 14.0")
        }
    }
}
