//
//  ViewController.swift
//  TDWebService
//
//  Created by abhimanu jindal on 11/13/2017.
//  Copyright (c) 2017 abhimanu jindal. All rights reserved.
//

import UIKit
import TDWebService

class ViewController: UIViewController {
    
    var tests: [Test] = [Test()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (_,test) in tests.enumerated(){
            test.call { (result) in
                switch result {
                case .Success(let movies):
                    print(movies)
                    
                case .Error(let error):
                    print(error)
                    
                }
            }
        }
        
        
        //test.call
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    //Test
}

struct User{
    
}

struct NehaoValidator: TDResultValidatorApi{
    func validateResponse(_ result: TDWSResult) -> TDResult<TDWSResult, TDError> {
        let resultJson = result as? [String: Any]
        if resultJson == nil{
            return TDResult.Error(TDError.init(Validation.NotAuthorised))
        }
        return TDResult.init(value: result)
    }
    
    enum Validation: Error{
        case NotValid
        case NotAuthorised
    }
    
}

class Test: TDWebService{
    
    
    func url() -> String {
        return "https://httpbin.org/get"
    }
    
    enum TestApiError: Error{
        case Unauthorised
    }
    
    func validalidatorClient() -> TDResultValidatorApi? {
        return NehaoValidator()
    }

    
    var handler : ((TDResult<User, TDError>) -> Void)?
    
    
    func call(_ completionHandler: @escaping (TDResult<User, TDError>) -> Void) {
        handler = completionHandler
        
        apiCall {(result) in
            switch result {
            case .Success(let resultString):
                print(resultString)
                //print(isResultValid)
            case .Error(let error):
                print(error)
                completionHandler(TDResult<User, TDError>.init(error: TestApiError.Unauthorised))
            }
            
        }
        
        DispatchQueue.main.async {
            self.cancel()
        }
    }
}


