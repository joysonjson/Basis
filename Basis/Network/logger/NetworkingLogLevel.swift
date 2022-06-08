//
//  NetworkingLogLevel.swift
//  ShopMore
//
//  Created by Joyson P S on 19/05/22.
//

import Foundation
/**
 Loglevels
 off mode is kept to avoid wrting or printing in the production build
 */

public enum NetworkingLogLevel {
    case off
    case info
    case debug
}
