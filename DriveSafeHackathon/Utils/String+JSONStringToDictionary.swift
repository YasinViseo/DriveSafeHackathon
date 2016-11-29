//
//  String+JSONStringToDictionary.swift
//  MY Renault
//
//  Created by lng3578 on 02/11/2016.
//  Copyright © 2016 VISEO. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

extension String {
    func JSONStringToDictionary() -> JSONDictionary? {
        
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
            } catch let error as NSError {
                print("Error : \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}
