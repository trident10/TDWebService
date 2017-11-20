//
//  ResponseValidatorApi.swift
//  TDServiceAPI
//
//  Created by Yapapp on 13/11/17.
//

import Foundation

public protocol TDResultValidatorApi{
    func isResponseValid(_ result: TDWSResult) -> TDResult<Bool, TDError>
}

struct TDResultValidatorApiDefault: TDResultValidatorApi{
    func isResponseValid(_ result: TDWSResult) -> TDResult<Bool, TDError>{
        return TDResult.init(value: true)
    }
}
