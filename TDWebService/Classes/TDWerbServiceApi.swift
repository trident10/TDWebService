//
//  WerbServiceApi.swift
//  TDServiceAPI
//
//  Created by Yapapp on 09/11/17.
//

import Foundation

public protocol TDWebServiceAPI{
    var request: TDWebServiceRequest? {get set}
    var response: AnyObject? {get set}
    mutating func call(_ request: TDWebServiceRequest, completionHandler: @escaping (TDResult<TDWSResult, TDError>) -> Void)
    func cancel()
    func cancelAll()
}

public struct TDWebServiceAPIDefault: TDWebServiceAPI {
    
    public init(){}
    
    public var request: TDWebServiceRequest?
    public var response: AnyObject?
    
    public mutating func call(_ request: TDWebServiceRequest, completionHandler: @escaping (TDResult<TDWSResult, TDError>) -> Void) {
        self.request = request
        print("Pending url session feature needs to be added")
    }
    
    public func cancel(){
        print("Pending url session feature needs to be added")
    }
    
    public func cancelAll(){
        print("Pending url session feature needs to be added")
    }
}
