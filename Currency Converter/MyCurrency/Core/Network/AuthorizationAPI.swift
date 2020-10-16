//
//  AuthorizationAPI.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

public func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

var authProvider: MoyaProvider<AuthRequest> {
    let formatter = NetworkLoggerPlugin.Configuration.Formatter(requestData: JSONResponseDataFormatter, responseData: JSONResponseDataFormatter)
    let authProvider = MoyaProvider<AuthRequest>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: formatter, logOptions: .verbose))])
    
    return authProvider
}

public enum AuthRequest {
    case register(title: String, firstName: String, lastName: String, email: String, countryCode: String, application: String)
    case updateUser(userID: String, title: String, firstName: String, lastName: String, email: String, countryCode: String, application: String)
    case getListOfCountries
    case getListOfCurrency
}

extension AuthRequest: TargetType {
    public var baseURL: URL {
        switch self {
        case .getListOfCurrency:
            return URL(string: Configuration.baseCurrencyUrl + Configuration.absoluteURL)!
        default:
            return URL(string: Configuration.baseCurrencyUrl)!
        }
        
        
    }
    
    public var path: String {
        switch self {
        case .register:
            return "lead"
        case .updateUser:
            return "lead"
        case .getListOfCountries:
            return "lead/countries"
        case .getListOfCurrency:
            let urlString = Configuration.absoluteURL
            print("--------- \(urlString) ------------")
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getListOfCountries, .getListOfCurrency:
            return .get
        case .updateUser:
            return .put
        default:
            return .post
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .register(title: let title, firstName: let firstName, lastName: let lastName, email: let email, countryCode: let countryCode, application: let application):
            params["app"] = application
            params["email"] = email
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["residency"] = countryCode
            params["title"] = title
            
        case .updateUser(userID: let userID, title: let title, firstName: let firstName, lastName: let lastName, email: let email, countryCode: let countryCode, application: let application):
            params["app"] = application
            params["id"] = userID
            params["title"] = title
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["email"] = email
            params["residency"] = countryCode
            
        default:
            return .requestPlain
        }
        if params.count > 0 {
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getListOfCountries:
            return URLEncoding.queryString
        default:
            return URLEncoding.default
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        default:
            return .successCodes
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    public var headers: [String : String]? {
        let headers: [String: String] = [:]
        return headers
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).debugDescription
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSDictionary() throws -> NSDictionary {
        let any = try self.mapJSON()
        guard let dictionary = any as? NSDictionary else {
            throw MoyaError.jsonMapping(self)
        }
        return dictionary
    }
    
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
    
    func mapAsObject() throws -> AnyObject {
        let any = try self.mapJSON()
        return any as AnyObject
    }
}
