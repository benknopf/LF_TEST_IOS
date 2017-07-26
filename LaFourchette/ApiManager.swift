//
//  ApiManager.swift
//  LaFourchette
//
//  Created by Benjamin Knopf on 25/07/2017.
//  Copyright © 2017 Benjamin Knopf. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ApiError: Error{
    case serverError
    case invalidJSON
    case restaurantNotFound
    case missingMethod
    case unknown
}

extension ApiError{
    var serverIdentifier: String{
        switch self {
        case .restaurantNotFound:
            return "RESTAURANT_NOT_FOUND"
        case .missingMethod:
            return "MISSING_METHOD"
        default:
            return ""
        }
    }
    
    var identifier: String{
        switch self {
        case .serverError:
            return "SERVER_ERROR"
        case .invalidJSON:
            return "INVALID_JSON"
        case .restaurantNotFound:
            return "RESTAURANT_NOT_FOUND"
        case .missingMethod:
            return "MISSING_METHOD"
        default:
            return "UNKNOWN_ERROR"
        }
    }
    
    var localizedDescription: String {
        return NSLocalizedString(self.serverIdentifier, comment: "")
    }
}

class ApiResult: Mappable {
    var count = 0
    var code: String?
    var message: String?
    var detail: String?
    var data: [String: Any]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        count <- map["result"]
        code <- map["result_code"]
        message <- map["result_msg"]
        detail <- map["result_detail"]
        data <- map["data"]
    }
    
    var error: Error?{
        get{
            if let code = self.code{
                switch code {
                case ApiError.restaurantNotFound.serverIdentifier:
                    return ApiError.restaurantNotFound
                case ApiError.missingMethod.serverIdentifier:
                    return ApiError.restaurantNotFound
                default:
                    return ApiError.unknown
                }
            }
            return nil
        }
    }
}


class ApiManager {
    static let shared = ApiManager()
    
    let url = "https://api.lafourchette.com/api"
    static let apiKey = "IPHONEPRODEDCRFV"
    
    func request(parameters: [String: Any], completion: @escaping ([String: Any]?, Error?) -> Void){
        var parameters = parameters
        parameters["key"] = ApiManager.apiKey
        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            if response.error != nil {
                let error = ApiError.serverError
                completion(nil, error)
            }else{
                if let json = response.value as? [String: Any]{
                    if let apiResult = ApiResult(JSON: json){
                        if let error = apiResult.error{
                            completion(nil, error)
                        }else{
                            completion(apiResult.data, nil)
                        }
                    }
                }else{
                    let error = ApiError.invalidJSON
                    completion(nil, error)
                }
            }
        }
    }
}

