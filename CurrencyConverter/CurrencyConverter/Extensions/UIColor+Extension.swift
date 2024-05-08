//
//  UIColor+Extension.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 16.03.23.
//

import UIKit
import SwiftUI

extension UIColor {
    static var tabBarItemAccent: UIColor {
        UIColor.systemCyan
    }
    
    static var mainWhite: UIColor {
        UIColor.white
    }
    
    static var tabBarItemLight: UIColor {
        UIColor.gray
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

/// Example = UIColor(hexString: "010000", alpha: 0)

enum ColorName: String {
    case achromatic = "achromatic"
    case black = "black"
    case blue = "blue"
    case blue20 = "blue20"
    case blue50 = "blue50"
    case c2073C0 = "c2073C0"
    case c3046B2 = "c3046B2"
    case c5470Fb = "c5470FB"
    case c54B5Fb = "c54B5FB"
    case cyan = "cyan"
    case cyan20 = "cyan20"
    case cyan50 = "cyan50"
    case darkBlue = "darkBlue"
    case gray = "gray"
    case gray0 = "gray0"
    case gray10 = "gray10"
    case gray100 = "gray100"
    case gray20 = "gray20"
    case gray30 = "gray30"
    case gray50 = "gray50"
    case gray57 = "gray57"
    case gray60 = "gray60"
    case gray70 = "gray70"
    case gray80 = "gray80"
    case green = "green"
    case green20 = "green20"
    case green50 = "green50"
    case orange = "orange"
    case orange20 = "orange20"
    case red = "red"
    case red20 = "red20"
    case red50 = "red50"
    case turquoise = "turquoise"
    case white = "white"
    case yellow = "yellow"
    case yellow20 = "yellow20"
}

enum ImageName: String {
    case splashBackground = "splashBackground"
    case alert = "alert"
    case alertBlocked = "alertBlocked"
    case applePay = "applePay"
    case arrowDownTriangle = "arrowDownTriangle"
    case arrowRightTriangle = "arrowRightTriangle"
    case arrowUpTriangle = "arrowUpTriangle"
    case dollar = "dollar"
    case euro = "euro"
    case fav = "fav"
    case favCard = "favCard"
    case ruble = "ruble"
    case sliderIndicator = "slider_indicator"
    case sms = "sms"
    case authenticationMethods = "authenticationMethods"
    case blockAccess = "blockAccess"
    case deleteBGIcon = "deleteBGIcon"
    case deviceLog = "deviceLog"
    case education = "education"
    case enterCode = "enterCode"
    case faceIdProfile = "faceIdProfile"
    case feedback = "feedback"
    case language = "language"
    case legalInformation = "legalInformation"
    case mainCard = "main_card"
    case mainScreen = "main_screen"
    case paymentNumber = "payment_number"
    case person = "person"
    case profileMap = "profile_map"
    case security = "security"
    case smpGrayRound = "smpGrayRound"
    case statementByProduct = "statement_by_product"
    case touchIdProfile = "touchIdProfile"
    case transferSettings = "transfer_settings"
    case account = "account"
    case accountNewProduct = "accountNewProduct"
    case accounts = "accounts"
    case arrowUnionDown = "arrowUnionDown"
    case arrowUnionUp = "arrowUnionUp"
    case arrowDown = "arrow_down"
    case arrowDownLine = "arrow_down_line"
    case arrowLeftLine = "arrow_left_line"
    case arrowLeftLineWhiteColor = "arrow_left_line_white_color"
    case arrowNested = "arrow_nested"
    case arrowRight = "arrow_right"
    case arrowRightLine = "arrow_right_line"
    case arrowUp = "arrow_up"
    case arrowUpLine = "arrow_up_line"
    case atmIcon = "atmIcon"
    case autopay = "autopay"
    case bank = "bank"
    case bankIcon = "bankIcon"
    case bePaidTemplate = "bePaidTemplate"
    case budget = "budget"
    case calculator = "calculator"
    case calendar = "calendar"
    case card = "card"
    case cardHide = "cardHide"
    case cardShow = "cardShow"
    case chat = "chat"
    case checkboxOff = "checkboxOff"
    case checkboxOn = "checkboxOn"
    case checkmark = "checkmark"
    case clear = "clear"
    case clock = "clock"
    case clockGray = "clockGray"
    case close = "close"
    case closeBG = "closeBG"
    case closeProduct = "closeProduct"
    case closeBgDark = "close_bg_dark"
    case coins = "coins"
    case coinsGray = "coinsGray"
    case contacts = "contacts"
    case creditPercent = "creditPercent"
    case creditPayments = "credit_payments"
    case day = "day"
    case delete = "delete"
    case deleteTemplate = "deleteTemplate"
    case deposit = "deposit"
    case depositNewProduct = "depositNewProduct"
    case desktop = "desktop"
    case doc = "doc"
    case docV2 = "docV2"
    case docs = "docs"
    case download = "download"
    case dragnDrop = "dragn_drop"
    case edit = "edit"
    case editTemplate = "editTemplate"
    case enter = "enter"
    case evening = "evening"
    case exchange = "exchange"
    case exchangeIcon = "exchangeIcon"
    case eyeClosed = "eye_closed"
    case eyeOpen = "eye_open"
    case filter = "filter"
    case geo = "geo"
    case help = "help"
    case hideBalance = "hideBalance"
    case home = "home"
    case iParitet = "iParitet"
    case infoKiosk = "infoKiosk"
    case informer = "informer"
    case inside = "inside"
    case largePerson = "largePerson"
    case logOut = "log_out"
    case logOutBlack = "log_out_black"
    case map = "map"
    case mapPin = "mapPin"
    case metroBlue = "metro_blue"
    case metroGreen = "metro_green"
    case metroRed = "metro_red"
    case mic = "mic"
    case minus = "minus"
    case mobile = "mobile"
    case more = "more"
    case morning = "morning"
    case night = "night"
    case oneButton = "one_button"
    case oneButtonBold = "one_button_bold"
    case passport = "passport"
    case paymentByPhone = "paymentByPhone"
    case pen = "pen"
    case percent = "percent"
    case phone = "phone"
    case phoneDots = "phone_dots"
    case plus = "plus"
    case pointOnMap = "pointOnMap"
    case qr = "qr"
    case receive = "receive"
    case refresh = "refresh"
    case rename = "rename"
    case requestCall = "requestCall"
    case scanCard = "scanCard"
    case schedule = "schedule"
    case search = "search"
    case sendCVV = "sendCVV"
    case settings = "settings"
    case settingsLimits = "settingsLimits"
    case share = "share"
    case smpBank = "smpBank"
    case smsNotification = "smsNotification"
    case statements = "statements"
    case swap = "swap"
    case swapGray = "swapGray"
    case swapRates = "swapRates"
    case swapHorizontal = "swap_horizontal"
    case swipePlus = "swipePlus"
    case tarif = "tarif"
    case time = "time"
    case turnOn = "turnOn"
    case turnOnCard = "turnOnCard"
    case up = "up"
    case visibilityEye = "visibility_eye"
    case wallet = "wallet"
    case scanQR = "scanQR"
    case editWithCircle = "editWithCircle"
    case eur = "eur"
    case funt = "funt"
    case pln = "pln"
    case rub = "rub"
    case usd = "usd"
    case bigPlusWithBackground = "bigPlusWithBackground"
    case cardBlocked = "cardBlocked"
    case cardWithBackground = "cardWithBackground"
    case coinsBlue = "coinsBlue"
    case coinsBundleDarkBlue = "coinsBundleDarkBlue"
    case depositsDarkBlue = "depositsDarkBlue"
    case docsGrayBGIcon = "docsGrayBGIcon"
    case erip = "erip"
    case fastPhone = "fastPhone"
    case homeBGblue = "homeBGblue"
    case infoKioskBGIcon = "infoKioskBGIcon"
    case paymentBGblue = "paymentBGblue"
    case pointer = "pointer"
    case roundedAtm = "roundedAtm"
    case roundedCurrencyExchange = "roundedCurrencyExchange"
    case roundedOffice = "roundedOffice"
    case roundedPartnerAtm = "roundedPartnerAtm"
    case route = "route"
    case sendEmail = "sendEmail"
    case tarifWithBG = "tarifWithBG"
    case timeBGblue = "timeBGblue"
    case unblockCard = "unblockCard"
    case addFileButton = "addFileButton"
    case bannerGradient = "bannerGradient"
    case belCard = "belCard"
    case cardWhite = "card_white"
    case chatFileIcon = "chatFileIcon"
    case chatFileIconWhiteBackground = "chatFileIconWhiteBackground"
    case coinsBundle = "coinsBundle"
    case coinsBundleGray = "coinsBundleGray"
    case coinsWithBG = "coinsWithBG"
    case credit = "credit"
    case defaultCard = "defaultCard"
    case deposits = "deposits"
    case depositsWhiteBG = "depositsWhiteBG"
    case docsBGIcon = "docsBGIcon"
    case favBGIcon = "favBGIcon"
    case imagePreview = "imagePreview"
    case maestroCard = "maestroCard"
    case masterCard = "masterCard"
    case mirCard = "mirCard"
    case personBGIcon = "personBGIcon"
    case pinAtm = "pinAtm"
    case pinCurrencyExchange = "pinCurrencyExchange"
    case pinOffice = "pinOffice"
    case pinPartnerAtm = "pinPartnerAtm"
    case repeatBGIcon = "repeatBGIcon"
    case squareBGIcon = "squareBGIcon"
    case totalFunds = "totalFunds"
    case visaCard = "visaCard"
    case error = "error"
    case pending = "pending"
    case success = "success"
    case faceIdPin80 = "faceIdPin80"
    case smpBlue = "smpBlue"
    case touchIdPin80 = "touchIdPin80"
    case userProfileImage = "userProfileImage"
    case cardBackgroundBlack = "cardBackgroundBlack"
    case cardIsBeingProduced = "cardIsBeingProduced"
    case belCardLogo = "belCardLogo"
    case masterCardLogo = "masterCardLogo"
    case mirCardLogo = "mirCardLogo"
    case paritetCardLogo = "paritetCardLogo"
    case visaCardLogo = "visaCardLogo"
    case catalogAccountAndDepo = "catalog_account_and_depo"
    case catalogCard = "catalog_card"
    case catalogCredits = "catalog_credits"
    case backgroundCreditDetail = "backgroundCreditDetail"
    case backgroundDepositDetail = "backgroundDepositDetail"
    case deletePin = "deletePin"
    case faceIdPin = "faceIdPin"
    case indicator = "indicator"
    case touchIdPin = "touchIdPin"
    case paritetLogo = "ParitetLogo"
    case dayBackground = "dayBackground"
    case eveningBackground = "eveningBackground"
    case morningBackGround = "morningBackGround"
    case nightBackground = "nightBackground"
    case splashLogo = "splashLogo"
    case applePayMark = "apple_pay_mark"
    case bannerBackground = "bannerBackground"
    case cardIsOnTheWay = "cardIsOnTheWay"
    case cardOpenBanner = "cardOpenBanner"
    case circle = "circle"
    case clearWhite = "clear_white"
    case creditsBGBanner = "creditsBGBanner"
    case currencyRounded = "currencyRounded"
    case defaultProduct = "defaultProduct"
    case historyCommission = "historyCommission"
    case insideWithBackground = "insideWithBackground"
    case loanApplicationTime = "loanApplicationTime"
    case logo = "logo"
    case history916History01 = "history9_16_history_01"
    case history916History02 = "history9_16_history_02"
    case history916History03 = "history9_16_history_03"
    case history916History04 = "history9_16_history_04"
    case history9195History01 = "history9_19.5_history_01"
    case history9195History02 = "history9_19.5_history_02"
    case history9195History03 = "history9_19.5_history_03"
    case history9195History04 = "history9_19.5_history_04"
    case home916Home01 = "home9_16_home_01"
    case home916Home02 = "home9_16_home_02"
    case home916Home03 = "home9_16_home_03"
    case home916Home04 = "home9_16_home_04"
    case home916Home05 = "home9_16_home_05"
    case home916Home06 = "home9_16_home_06"
    case home916Home07 = "home9_16_home_07"
    case home916Home08 = "home9_16_home_08"
    case home916Home09 = "home9_16_home_09"
    case home9195Home01 = "home9_19.5_home_01"
    case home9195Home02 = "home9_19.5_home_02"
    case home9195Home03 = "home9_19.5_home_03"
    case home9195Home04 = "home9_19.5_home_04"
    case home9195Home05 = "home9_19.5_home_05"
    case home9195Home06 = "home9_19.5_home_06"
    case home9195Home07 = "home9_19.5_home_07"
    case home9195Home08 = "home9_19.5_home_08"
    case home9195Home09 = "home9_19.5_home_09"
    case payment916Payments01 = "payment9_16_payments_01"
    case payment916Payments02 = "payment9_16_payments_02"
    case payment9195Payments01 = "payment9_19.5_payments_01"
    case payment9195Payments02 = "payment9_19.5_payments_02"
    case preAuthorized916PreAuthorizedZone01 = "preAuthorized9_16_pre-authorized_zone_01"
    case preAuthorized916PreAuthorizedZone02 = "preAuthorized9_16_pre-authorized_zone_02"
    case preAuthorized916PreAuthorizedZone03 = "preAuthorized9_16_pre-authorized_zone_03"
    case preAuthorized916PreAuthorizedZone04 = "preAuthorized9_16_pre-authorized_zone_04"
    case preAuthorized9195PreAuthorizedZone01 = "preAuthorized9_19.5_pre-authorized_zone_01"
    case preAuthorized9195PreAuthorizedZone02 = "preAuthorized9_19.5_pre-authorized_zone_02"
    case preAuthorized9195PreAuthorizedZone03 = "preAuthorized9_19.5_pre-authorized_zone_03"
    case preAuthorized9195PreAuthorizedZone04 = "preAuthorized9_19.5_pre-authorized_zone_04"
    case otherOperations = "otherOperations"
    case roundBGIcon = "roundBGIcon"
    case story1 = "story1"
    case story1Thumbnail = "story1Thumbnail"
    case story2 = "story2"
    case story2Thumbnail = "story2Thumbnail"
    case story3 = "story3"
    case story3Thumbnail = "story3Thumbnail"
    case tempCard = "tempCard"
    case tempUser = "temp_user"
}

// MARK: - UIKit Assets Initialization

extension UIColor {
    convenience init?(named: ColorName) {
        self.init(named: named.rawValue, in: Bundle.main, compatibleWith: nil)
    }
}

extension UIImage {
    convenience init?(named imageName: ImageName?) {
        guard let imageName = imageName else { return nil }
        self.init(named: imageName.rawValue)
    }
}

// MARK: - SwiftUI Assets Initialization

extension Color {
    init(named: ColorName) {
        self.init(named.rawValue, bundle: Bundle.main)
    }
}

extension Image {
    init(named imageName: ImageName) {
        let image = UIImage(named: imageName) ?? UIImage()
        self.init(uiImage: image)
    }
}
