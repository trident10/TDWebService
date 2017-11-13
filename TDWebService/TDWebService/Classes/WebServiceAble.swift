//
//  File.swift
//  TDServiceAPI
//
//  Created by Yapapp on 07/11/17.
//

import Foundation

public protocol WebServiceAble {
    
    // These should be called only by configurator to create webservice request
    
    func bodyParameters() -> [String:Any]?
    
    func headerParameters() -> [String:String]?
    
    func url() -> String
    
    func requestTimeOut()->Int
    
    func apiClient() -> WebServiceAPI
    
    func resultValidatorClient() -> ResultValidatorApi
    
    func methodType() -> MethodType
    
    func encodingType() -> URLEncodingType
    
    func resultType() -> ResultType
    
}

public extension WebServiceAble{
    
    public func bodyParameters()->[String:Any]?{
        return nil
    }
    
    public func headerParameters()->[String:String]?{
        return nil
    }
    
    public func requestTimeOut()->Int{
        return 60
    }
    
    public func apiClient() -> WebServiceAPI{
        return WebServiceAPIDefault()
    }
    
    func resultValidatorClient() -> ResultValidatorApi{
        return DefaultResultValidatorApi()
    }
    
    public func methodType()->MethodType{
        return .GET
    }
    
    public func encodingType()->URLEncodingType{
        return .QUERY
    }
    
    func resultType() -> ResultType{
        return .String
    }
    
    public func apiCall(_ completionHandler: @escaping (Result<WSResult, WSError>) -> Void){
        var configurator = WebServiceConfiguratorClient()
        configurator.dataSource = self
        let result = configurator.createRequest()
        switch result {
        case .Success(let webServiceRequest):
            let api = configurator.getApi()
            call(webServiceRequest, api: api, completionHandler: {(result) in
                completionHandler(result)
            })
            
        case .Error(let error):
            completionHandler(Result.Error(error))
        }
    }
    
    public func validateResult(_ result: WSResult) -> Result<Bool, WSError>{
        var configurator = WebServiceConfiguratorClient()
        configurator.dataSource = self
        return configurator.validateResult(result)
    }
    
    private func call(_ request: WebServiceRequest, api: WebServiceAPI, completionHandler: @escaping (Result<WSResult, WSError>) -> Void){
        api.call(request) { (result) in
            completionHandler(result)
        }
    }

}
