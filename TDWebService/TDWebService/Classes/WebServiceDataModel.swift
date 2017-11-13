//
//  WebServiceDataModel.swift
//  TDServiceAPI
//
//  Created by Yapapp on 09/11/17.
//

import Foundation

public enum MethodType {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum URLEncodingType{
    case FORM
    case QUERY
    case JSONENCODING
    case FileUpload
}

public enum ResultType{
    case String
    case Data
    case JSON
}

public enum WebServiceError: Error{
    case RquestGenerationFailed
    case ResultValidationFailed
    case NetworkNotReachable
    case InvalidUrl
    case ApiError
    case JsonConversionFailure
    case JsonParsingFailure
}

public protocol WSError {
    var error: WebServiceError {get set}
    var code: Int? {get set}
    var description: String? {get set}
}

public struct TDWSError: WSError {
    public var error: WebServiceError
    public var code: Int?
    public var description: String?
    
    init(_ error: WebServiceError) {
        self.error = error
    }
    
    init(_ error: WebServiceError, code: Int? = nil, description: String? = nil) {
        self.error = error
        self.code = code
        self.description = description
    }
}

public protocol WSResult {}
extension String: WSResult{}
extension Data: WSResult{}
extension Json: WSResult{}

struct Json {
    var jsonData: AnyObject?
}

public struct WebServiceRequest{
    var methodType: MethodType = .GET
    var urlEncodingType: URLEncodingType = .FORM
    var url: String = ""
    var parameters:[String:Any]?
    var headers:[String:String]?
    var resultType: ResultType = .String
    var timeOutSession = 60
}
