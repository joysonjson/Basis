//
//  OTPVerificationViewModel.swift
//  Basis
//
//  Created by Joyson P S on 11/06/22.
//

import Foundation
struct OTPVerificationViewModel{
    var verify: Observable<VerifyUser> = Observable(nil)
    var error: Observable<String> = Observable(nil)
    var user: Observable<VerifyUser> = Observable(nil)

    let httpUtility = HttpRequest.shared

    func verifyUser(){
        let jsonData = try! JSONEncoder().encode(verify.value)

        httpUtility.postApiData(endpoint: .sendotp,data: jsonData,resultType: EmailToken.self) { (res) in
//            self.token.value = res
        } andFailure: { (err) in
            self.error.value = err
        }
    }

}

