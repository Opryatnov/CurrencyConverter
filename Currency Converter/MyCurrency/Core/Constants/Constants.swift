//
//  Constants.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import Foundation
import SwiftTheme

struct Configuration {
    static let baseDomain = "https://xaqo8ryava.execute-api.eu-central-1.amazonaws.com/dev/"
    static let webSocket = "ws://lip-bab899b09f6b5844.elb.eu-central-1.amazonaws.com/leads/websocket"
    
    static let baseCurrencyUrl = "https://www.nbrb.by/"
    
    static let accessToken = "rightHere"
    static let clientID = ""
    static let loader = "18289-stay-home-stay-safe-red"
    
    static let absoluteURL = "api/exrates/rates?periodicity=0"
    static let appleAppID = ""
    static let name = ""
    static let version = "v1/"
    static let messageString = ""
}

public struct ConstantDefault {
    static let signUpButtonSendIvent = "SIGNUP_ENTER"
    static let loginButtonSendIvent = "LOGIN_ENTER"
    static let webFormSendIvent = "PERSONAL_INFO_CORRECT"
    static let successScreenSendIvent = "WAITING_LIST_PASSED"
    static let requestNotification = "NOTIFICATIONS_REQUEST"
    static let notificationConfirm = "NOTIFICATIONS_CONFIRM"
    static let notificationReject = "NOTIFICATIONS_REJECT"
    static let notificationSkip = "NOTIFICATIONS_REQUEST_REJECT"
    
    static let lastController = "lastController"
    static let notificationIsActive = "notificationsIsActive"
}

public struct ConstantUserDefaults {
    static let user = "\(Configuration.name).UserDefaults.User.Key"
}

public struct ConstantValidation {
    static let avalibaleBackgroundSessionTime: TimeInterval = 2 * 60
    static let sessionActiveTime: Int = 15
    static let phoneLimit = 12
    static let smsLimit = 4
    static let ibanLimit = 42
    static let swiftBicLimit = 11
    static let pinLimit = 6
    static let cardPinLimit = 4
    static let offsetForLoadingItem = 10
    static let availableSymbols = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    static let availableSymbylsWithSpace = " \(availableSymbols)"
    static let availableNameSymbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    static let availableEmailSymbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-@._"
    static let availableSymbylsForName = " \(availableNameSymbols)"
    static let availableSymbylsForEmail = " \(availableEmailSymbols)"
}

public struct ConstantFonts {
    static let titleFontKeyPadButtons = UIFont(name: "SFProDisplay-Regular", size: 36)
    static let subtutleFontKeyPadButtons = UIFont(name: "SFProText-Medium", size: 10)
    static let titleFontHeaderTableView = UIFont(name: "SFProText-Semibold", size: 17)
}

enum ColorElement {

// New Colors
static let titleGoldMainColor = ["#FFFFFF"]
static let themeGoldBackground: ThemeColorPicker = ["#000000"]
static let themeGoldTitleMainColor = ["#FFFFFF"]
static let themeGoldTextFieldMainColor = ["#000000"]
static let themeGoldTextConfirmScreenMainColor = ["#9F9FA4"]
static let themeGoldSubTitleMainColor = ["#98989E"]
static let themeGoldTextfieldInactive = ["#84949A"]
static let themeGoldTextfieldActive = ["#84949A"]
static let themeGoldTextfieldPlaceHolderInactive = ["#E6E6E6"]
static let themeGoldTextfieldTitleNormal = ["#FFFFFF"]
static let themeGoldSubTitleColor = ["#F3F3F9"]
static let themeGoldSubTitleRegularColor = ThemeColorPicker.pickerWithColors(themeGoldSubTitleColor)
static let themeGoldTitleRegular = ThemeColorPicker.pickerWithColors(themeGoldTitleMainColor)
static let themeGoldSubTitleRegular = ThemeColorPicker.pickerWithColors(themeGoldSubTitleMainColor)
static let themeGoldConfirmScreenTitleRegular = ThemeColorPicker.pickerWithColors(themeGoldTextConfirmScreenMainColor)
static let themeGoldTabBarBackground: ThemeColorPicker = ["#2C2C2E"]
static let themeGoldTopUpBackground: ThemeColorPicker = ["#1C1C1E"]
static let themeGoldExchangeKeyboard: ThemeKeyboardAppearancePicker = [.dark]
static let themeGoldEcxhangeTextfieldTitleNormal: ThemeColorPicker = ["#FFFFFF"]
static let themeGoldDarkGreyColor: ThemeColorPicker  = ["#3C3C3E"]
static let themeGoldAccountNavigation: ThemeColorPicker = ["#1C1C1E"]
static let themeGoldSearchBarBackground: ThemeColorPicker = ["#323235"]
static let themeGoldExchangeButtonTitile: ThemeColorPicker = ["#908E91"]
static let themeGoldExchangeCurrencyButtonTitile: ThemeColorPicker = ["#FFFFFF"]
static let themeGoldCurrecnyPickerBackground: ThemeColorPicker = ["#2C2C2E"]
static let themeGoldContainerViewBackground: ThemeColorPicker = ["#2C2C2E"]
static let themeGoldContainerTextFiledViewBackground: ThemeColorPicker = ["#3A3A3C"]
static let themeGoldButtonsTextColor : ThemeColorPicker  = ["#FFFFFF"]
static let themeGoldSkyFloatingViewBackground: ThemeColorPicker = ["#2C2C2E"]
static let themeGoldBorderCellcolor : ThemeCGColorPicker  = ["#48484A"]
static let themeGoldBackgroundForImage: ThemeColorPicker = ["#FFFFFF"]
static let themeGoldTableSectionText = ["#84949A"]
static let themeGoldTableSectionBackground = ["#2D3436"]
static let themeGoldSeparator: ThemeColorPicker = ["#8E8E93"]
    
    // Cards and Accounts
       static let themeGoldPageIndicator: ThemeColorPicker = ["#3E3E42"]
       static let themeGoldCurrentPageIndicator: ThemeColorPicker = ["#FFFFFF"]
       static let themeGoldCGDashBorderColor: ThemeCGColorPicker = ["#48484A"]
       static let themeGoldCGBorderColor: ThemeCGColorPicker = ["#C59A78"]
       static let themeGoldCGBorderColorClear: ThemeCGColorPicker = ["#1C1C1E"]
       // Global
       static let background: ThemeColorPicker = ["#FFFFFF", "#151616"]
       static let titleMainColor = ["#000000", "#F9FAFB"]
       static let titleMainColorGray = ["#B2BEC3", "#808080"]
       static let titleMainColorBlack = ["#000000", "#000000"]
       static let titleMainColorWhite = ["#FFFFFF", "#FFFFFF"]
       static let titleRegular = ThemeColorPicker.pickerWithColors(titleMainColor)
       static let titleRegularGray = ThemeColorPicker.pickerWithColors(titleMainColorGray)
       static let titleRegularBlack = ThemeColorPicker.pickerWithColors(titleMainColorBlack)
       static let titleRegularWhite = ThemeColorPicker.pickerWithColors(titleMainColorWhite)
       static let titleRegularDisabled: ThemeColorPicker = ["#00000033", "#F9FAFB33"]
       static let separator: ThemeColorPicker = ["#C8C7CC", "#979797"]
       static let separatorDark: ThemeColorPicker = ["#B2BEC3", "#151616"]
       static let confirmHeaderBackground: ThemeColorPicker = ["#F9F9F9", "#2D3436"]
       
       // Registration
       static let main: ThemeColorPicker = ["#2E3D59"]
       static let clear = ["#00000000", "#00000000"]
       static let tabBarStyle = ThemeBarStylePicker(styles: .default, .black)
       static let tabBarBackground: ThemeColorPicker = ["#F8F8F8", "#222C32"]
       static let textfieldInactive = ["#84949A", "#84949A"]
       static let textfieldActive = ["#0984E3", "#84949A"]
       static let textfieldSuccess = ["#7FDBC9", "#7FDBC9"]
       static let textfieldError = ["#E17055", "#E17055"]
       static let textfieldErrorLight = ["#E99480", "#E99480"]
       static let textfieldDisable = ["#DFE6E9", "#2D3436"]
       static let textfieldDisableGray = ["#F9FAFB", "#2D3436"]
       static let tableSectionText = ["#000000", "#84949A"]
       static let tableSectionBackground = ["#F3F3F3", "#2D3436"]
       static let pinBackground = ["#EFEFF4", "#2D3436"]
       static let textfieldTitleNormal = ["#2D3436", "#2D3436"]
       static let buttonActive: ThemeColorPicker = ["#0984E3", "#0984E3"]
       static let buttonInactive: ThemeColorPicker = ["#DFE6E9", "#DFE6E9"]
       static let buttonAddBeneficiary: ThemeColorPicker = [ "#0984E3" , "#DFE6E9"]
       
       // Exchange
       static let exchangeButtonTitile: ThemeColorPicker = ["#000000", "#F9FAFB"]
       static let exchangeTitleMainColor = ["#000000", "#F9FAFB"]
       static let exchangeKeyboard: ThemeKeyboardAppearancePicker = [ .light, .dark,]
       static let ecxhangeTextfieldTitleNormal: ThemeColorPicker = ["#000000", "#FFFFFF"]
       static let borderCellcolor: ThemeCGColorPicker  = ["#EAEEF1","#424A4D"]
       
       // Payments
       static let backgroundForImage: ThemeColorPicker = ["#000000", "#FFFFFF"]
       static let pinBackgroundForimage: ThemeColorPicker = ["#C1E0F8", "#2D3436"]
       static let backgroundForOtherPaymentsImage: ThemeColorPicker = ["#C1E0F8", "#2D3436"]
       static let backgroundForDeleteCardImage: ThemeColorPicker = ["#F9FAFB", "#2D3436"]
       static let backgroundForBenefeciaryPaymentsImage: ThemeColorPicker = ["#FAFBFB", "#2D3436"]
       static let titlePaymentsColor: ThemeColorPicker = ["#2D3436", "#F9FAFB"]
       static let paymentsTextViewTitleNormal: ThemeColorPicker = ["#B2BEC3", "#B2BEC3"]
       
       // Accounts
       static let accountNavigation: ThemeColorPicker = ["#F9FAFB", "#151616"]
       static let borderNotificationButtonColor: ThemeCGColorPicker  = ["#000000","#FFFFFF"]
       static let accountBackground: ThemeColorPicker = ["#FFFFFF", "#2D3436"]
       static let accountButton: ThemeColorPicker = ["#2D3436", "#FFFFFF"]
       static let accountSeparator: ThemeColorPicker = ["#CCCCCC", "#FFFFFF"]
       static let accountCGDashBorderColor: ThemeCGColorPicker = ["#DFE6E9", "#424A4D"]
       static let currentPageIndicator: ThemeColorPicker = ["#2D3436", "#F9FAFB"]
       static let pageIndicator: ThemeColorPicker = ["#CCCCCC", "#424A4D"]
       static let verticalLineAndBorder: ThemeColorPicker = ["#CCCCCC", "#444545"]
       static let accountNotificationTitleColor: ThemeColorPicker = ["#525D61", "#B2BEC3"]
       static let accountNotificationCloseButtonTintColor: ThemeColorPicker = ["#B2BEC3", "#636E72"]
       static let accountNotificationSubTitleColor: ThemeColorPicker = ["#525D61", "#84949A"]
       static let accountNotificationCloseButtonImage: ThemeImagePicker = ["ic_notification_close", "ic_notification_close_dark_mode"]
       static let searchBarTextColor : ThemeColorPicker  = ["#FFFFFF","#FFFFFF"]
       static let backgroundDetailsCurrencyImage: ThemeColorPicker = ["#525D61", "#FFFFFF"]
       static let headerBackground: ThemeColorPicker = ["#F9FAFB", "#151616"]
       static let currencyViewBorderColor: ThemeCGColorPicker = ["#F9FAFB", "#151616"]
       static let currencyViewBackgroundColor: ThemeColorPicker = ["#FFFFFF", "#000000"]
       static let titleDetailsMainColor = ["#2D3436", "#FFFFFF"]
       static let titleDetailsRegular = ThemeColorPicker.pickerWithColors(titleDetailsMainColor)
       
       //Analytic
       static let segmentControlCurrent: ThemeColorPicker = ["#FFFFFF", "#151616"]
       static let segmentControlBackgraund: ThemeColorPicker = ["#EAEEF1", "#2D3436"]
       
       //Settings
       static let borderSettingsCellcolor: ThemeCGColorPicker  = ["#E8EDF0","#424A4D"]
       static let buttonsTextColor: ThemeColorPicker  = ["#000000","#FFFFFF"]
       static let activeButton: ThemeColorPicker = ["#FFFFFF", "#FFFFFF"]
       static let inactiveButton: ThemeColorPicker = ["#FFFFFF", "#2D3436"]

}

