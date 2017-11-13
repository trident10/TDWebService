//
//  Result.swift
//  TDServiceAPI
//
//  Created by Yapapp on 09/11/17.
//

import Foundation

public enum Result<T, E> {
    case Success(T)
    case Error(E)
    
    init(value: T) {
        self = .Success(value)
    }
    
    init(error: E) {
        self = .Error(error)
    }
}

