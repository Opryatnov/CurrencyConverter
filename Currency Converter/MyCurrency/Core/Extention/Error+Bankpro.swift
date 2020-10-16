//
//  Error+Bankpro.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import Moya

enum BankproErrorDetails: Int {
//    case connectedFailed = -1009
//    case connectedTimeOut = -1001
    case connectedFailed = 13
    case connectedTimeOut 
    
    func errorString() -> String? {
        switch self {
        case .connectedFailed:
            return "Please check your internet connection or try again later"
        case .connectedTimeOut:
            return "Превышен лимит времени на запрос"
        }
    }
    
    func returnedScreen() -> ErrorScreenType? {
        switch self {
        case .connectedFailed:
            return .internetConnectionError
        case .connectedTimeOut:
            return .connectiontTimedOutError
        }
    }
}

enum ErrorType: String {
    case repeatFaliedNoStrinpeCard = "REPEAT_FAILED_NO_STRIPE_CARD"
    case topUpAccountForRepeat = "TOP_UP_ACCOUNT_FOR_REPEAT"
    case balanceBellowZero = "BALANCE_BELOW_ZERO"
    case additionalCheckNeed = "Need"
    
    func returnedScreen() -> ErrorScreenType? {
        switch self {
        case .additionalCheckNeed:
            return .internetConnectionError
        default:
            return nil
        }
    }
}

public enum BankproError: Error {
    case custom(error: MoyaError)
}

public extension Error {
    var errorType: String? {
        return "ERROR"
    }
}

public extension MoyaError {
    /// Depending on error type, returns a `Response` object.
    var errorDetails: NSError? {
        switch self {
        case .imageMapping: return nil
        case .jsonMapping(_): return nil
        case .stringMapping(_): return nil
        case .objectMapping(let error, _): return error as NSError
        case .statusCode(_): return nil
        case .underlying(let error, _): return error as NSError
        case .encodableMapping: return nil
        case .requestMapping: return nil
        case .parameterEncoding: return nil
        }
    }
}

extension BankproError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .custom(let error):
            if let code = error.errorDetails?.code, let starError = BankproErrorDetails(rawValue: code) {
                return starError.errorString()
            }
            do {
                if let body = try error.response?.mapNSDictionary(), let errorString = body["message"] as? String {
                    return errorString
                }
            } catch {}
            return error.localizedDescription
        }
    }
    
    public var errorScreen: ErrorScreenType? {
        switch self {
        case .custom(error: let error):
            if let code = error.errorDetails?.code, let starError = BankproErrorDetails(rawValue: code) {
                return starError.returnedScreen()
            }
            if let description = self.errorType, let errorScreenType = ErrorType(rawValue: description) {
                return errorScreenType.returnedScreen()
            }
        }
        return nil
    }
    
    public var additionalCheckNeed: String? {
        switch self {
        case .custom(error: let error):
            if let description = self.errorType, description == "NEED_VERIFICATION", let authToken = error.response?.response?.allHeaderFields["twofactorauth-key"] as? String {
                return authToken
            }
        }
        return nil
    }
    
    public var errorType: String? {
        switch self {
        case .custom(let error):
            do {
                if let body = try error.response?.mapNSDictionary(), let errorString = body["errorType"] as? String {
                    return errorString
                }
            } catch {
                print(error)
            }
            return "ERROR"
        
        }
    }
}
