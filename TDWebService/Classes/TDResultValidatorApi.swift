//
//  ResponseValidatorApi.swift
//  TDServiceAPI
//
//  Created by Yapapp on 13/11/17.
//

import Foundation

public protocol TDResultValidatorApi{
    func validateResponse(_ result: TDWSResult) -> TDResult<TDWSResult, TDError>
}
