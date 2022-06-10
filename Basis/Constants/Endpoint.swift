//
//  Endpoint.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import Foundation


protocol EnvironmentProtocol {
    var baseURL: String { get }
}


enum URLEndpoint:String {
    case sendotp = "/candidate/users/email/"
}



enum APIEnvironment: EnvironmentProtocol {
    /// The development environment.
    case development
    /// The production environment.
    case production

    /// The default HTTP request headers for the given environment.
    /// The base URL of the given environment.
    var baseURL: String {
        switch self {
        case .development:
            return "https://hiring.getbasis.co"
        case .production:
            return "https://hiring.getbasis.co"
        }
    }
}
