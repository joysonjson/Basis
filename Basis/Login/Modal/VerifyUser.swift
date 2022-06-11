//
//  VerifyUser.swift
//  Basis
//
//  Created by Joyson P S on 11/06/22.
//

import Foundation
struct VerifyUser: Codable{
    let email:String?
    let token: Int64?
    var verificationCode: String?
}
