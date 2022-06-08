//
//  ErrorResponse.swift
//  ShopMore
//
//  Created by Joyson P S on 19/05/22.
//

import Foundation

struct ErrorResponse: Decodable {
    let documentation_url: URL?
    let errors: [CustomeError]?
    let message: String?
}

struct  CustomeError: Decodable {
    let code: String?
    let field: String?
    let message: String?
    let resource: String?
}
