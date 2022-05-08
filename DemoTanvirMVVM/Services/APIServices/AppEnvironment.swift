//
//  Environment.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 8/5/22.
//

import Foundation

public enum AppEnvironment: String, CaseIterable {
    case development
    case staging
    case production
}

extension AppEnvironment {
    var baseURl: String {
        switch self {
        case .development:
            return "https://jsonplaceholder.typicode.com"
        case .staging:
            return "https://jsonplaceholder.typicode.com"
        case .production:
            return "https://jsonplaceholder.typicode.com"
        }
    }
}
