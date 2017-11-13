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
    
    lazy var test = Test()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test.call { (result) in
            switch result {
            case .Success(let movies):
                print(movies)
                
            case .Error(let error):
                print(error)
                
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

class Test: WebServiceAble{
    
    func url() -> String {
        return "https://httpbin.org/get"
    }
    
    enum TestApiError: Error{
        case Unauthorised
    }
    
    var handler : ((Result<User, TestApiError>) -> Void)?
    
    
    func call(_ completionHandler: @escaping (Result<User, TestApiError>) -> Void) {
        handler = completionHandler
        
        apiCall {[weak self](result) in
            switch result {
            case .Success(let resultString):
                let isResultValid = self?.validateResult(resultString)
                print(resultString)
                //print(isResultValid)
            case .Error(let error):
                print(error)
            }
            
        }
    }
}


