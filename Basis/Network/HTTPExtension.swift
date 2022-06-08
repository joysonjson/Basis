//
//  HTTPExtension.swift
//  ShopMore
//
//  Created by Joyson P S on 08/06/22.
//

import Foundation
extension URLRequest{
    mutating func addBody(param:[String:Any]?){
        let requestData = try? JSONSerialization.data(withJSONObject: param, options: [])
        self.httpBody = requestData
    }

    mutating func addBody(formdata:[String:Any]?){
        guard let data = formdata else { return  }
        let jsonString = data.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        self.httpBody = jsonString.data(using: .utf8, allowLossyConversion: false)!
    }
    
}
