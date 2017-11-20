//
//  File.swift
//  TDServiceAPI
//
//  Created by Yapapp on 07/11/17.
//

import Foundation
import ObjectiveC

public protocol TDWebService: class {
    
    func bodyParameters() -> [String:Any]?
    func headerParameters() -> [String:String]?
    func url() -> String
    func requestTimeOut()->Int
    func resultValidatorClient() -> TDResultValidatorApi
    func methodType() -> TDMethodType
    func encodingType() -> TDURLEncodingType
    func resultType() -> TDResultType
    
    func apiCall(_ completionHandler: @escaping (TDResult<TDWSResult, TDError>) -> Void)
    func cancel()
    func cancelAll()
    func validateResult(_ result: TDWSResult) -> TDResult<Bool, TDError>
    
}

private var xoAssociationConfigKey: UInt8 = 0
private var xoAssociationApiKey: UInt8 = 1

public extension TDWebService{
    
   public var configurator: TDWebServiceConfiguratorClient {
        get {
            return (objc_getAssociatedObject(self, &xoAssociationConfigKey) as? TDWebServiceConfiguratorClient)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
   public var api: TDWebServiceAPI {
        get {
            return (objc_getAssociatedObject(self, &xoAssociationApiKey) as? TDWebServiceAPIDefault)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationApiKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func bodyParameters()->[String:Any]?{
        return nil
    }
    
    public func headerParameters()->[String:String]?{
        return nil
    }
    
    public func requestTimeOut()->Int{
        return 60
    }
    
    public func apiClient() -> TDWebServiceAPI{
        return TDWebServiceAPIDefault()
    }
    
    public func resultValidatorClient() -> TDResultValidatorApi{
        return TDResultValidatorApiDefault()
    }
    
    public func methodType()-> TDMethodType{
        return .GET
    }
    
    public func encodingType()-> TDURLEncodingType{
        return .QUERY
    }
    
    public func resultType() -> TDResultType{
        return .String
    }
    
    public func apiCall(_ completionHandler: @escaping (TDResult<TDWSResult, TDError>) -> Void){
        configurator = TDWebServiceConfiguratorClient()
        configurator.dataSource = self
        let result = configurator.createRequest()
        switch result {
        case .Success(let webServiceRequest):
            api = configurator.getApi()
            api.call(webServiceRequest) { (result) in
                completionHandler(result)
            }
            
        case .Error(let error):
            completionHandler(TDResult.Error(error))
        }
    }
    
    func cancel(){
        api.cancel()
    }
    
    func cancelAll(){
        api.cancelAll()
    }
    
    public func validateResult(_ result: TDWSResult) -> TDResult<Bool, TDError>{
        var configurator = TDWebServiceConfiguratorClient()
        configurator.dataSource = self
        return configurator.validateResult(result)
    }

}
