//
//  String+DataValidation.swift
//  MY Renault
//
//  Created by lng3578 on 07/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
		let pattern = "[A-Za-z0-9\"_]+[A-Za-z0-9\"._%+-]*[A-Za-z0-9\"_]+@([A-Za-z0-9]+[A-Za-z0-9.-])+\\.[A-Za-z0-9]{2,6}"
        return evaluate(using: pattern)
    }
    
    func isURL() -> Bool {
        // Method 1
        if let candidateURL = URL(string: self), let _ = candidateURL.scheme, let _ = candidateURL.host {
            return true
        }
        
        // Method 2
        let pattern = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w-\\+ ./?%&amp;=]*)?"
        return evaluate(using: pattern)
    }
    
    func isIP() -> Bool {
        let pattern = "^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.([01]?\\d\\d?|2[0-4]\\d|25[0-5])$"
        return evaluate(using: pattern)
    }
    
    private func evaluate(using pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: self)
    }

}
