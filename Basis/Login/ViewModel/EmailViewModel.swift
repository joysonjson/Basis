//
//  EmailViewModel.swift
//  Basis
//
//  Created by Joyson P S on 10/06/22.
//

import Foundation
struct EmailViewModel{
    var token: Observable<EmailToken> = Observable(nil)
    var error: Observable<String> = Observable(nil)

    let httpUtility = HttpRequest.shared

    func sendOtp(email: String){
        let data = ["email":email]
        httpUtility.postApiData(endpoint: .sendotp,data: data,resultType: EmailToken.self) { (res) in
            self.token.value = res
        } andFailure: { (err) in
            self.error.value = err
        }
    }

}
