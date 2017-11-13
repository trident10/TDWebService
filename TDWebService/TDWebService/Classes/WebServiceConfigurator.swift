//
//  WebServiceConfigurator.swift
//  TDServiceAPI
//
//  Created by Yapapp on 09/11/17.
//

import Foundation
import ReachabilitySwift

public protocol WebServiceConfigurator{
    var dataSource: WebServiceAble? {set get}
    func createRequest() -> Result<WebServiceRequest, WSError>
}

struct WebServiceConfiguratorClient: WebServiceConfigurator{
    var dataSource: WebServiceAble?
    
    func createRequest() -> Result<WebServiceRequest, WSError>{
        if dataSource == nil{
            return Result.Error(TDWSError.init(.RquestGenerationFailed))
        }
        if !isUrlVerified(urlString: dataSource?.url()){
            return Result.Error(TDWSError.init(.InvalidUrl))
        }
        if Reachability.init()?.currentReachabilityStatus == .notReachable{
            return Result.Error(TDWSError.init(.NetworkNotReachable))
        }
        var request = WebServiceRequest()
        request.methodType = (dataSource?.methodType())!
        request.urlEncodingType = (dataSource?.encodingType())!
        request.url = (dataSource?.url())!
        request.parameters = dataSource?.bodyParameters()
        request.headers = dataSource?.headerParameters()
        request.timeOutSession = (dataSource?.requestTimeOut())!
        request.resultType = (dataSource?.resultType())!
        return Result.init(value: request)
    }
    
    func validateResult(_ result: WSResult) -> Result<Bool, WSError>{
        if dataSource == nil{
            return Result.Error(TDWSError.init(.ResultValidationFailed))
        }
        let resultValidatorAPI = dataSource?.resultValidatorClient()
        if resultValidatorAPI != nil{
            return (resultValidatorAPI?.isResponseValid(result))!
        }
        return Result.Success(true)
        
    }
    
    func getApi()-> WebServiceAPI{
        return (dataSource?.apiClient())!
    }
    
    private func isUrlVerified (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL.init(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}
