//
//  ResponseValidatorApi.swift
//  TDServiceAPI
//
//  Created by Yapapp on 13/11/17.
//

import Foundation

public protocol ResultValidatorApi{
    func isResponseValid(_ result: WSResult) -> Result<Bool, WSError>
}

struct DefaultResultValidatorApi: ResultValidatorApi{
    func isResponseValid(_ result: WSResult) -> Result<Bool, WSError>{
        return Result.init(value: true)
    }
}
