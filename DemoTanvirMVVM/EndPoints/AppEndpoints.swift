//
//  ServiceEndpoints.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 8/5/22.
//

import Foundation

public typealias Headers = [String: String]

// Better WAY
// if you wish you can have multiple EndPoints like this in a project
enum AppEndpoints {
    
  // organise all the end points here for clarity
    case users,posts,usersPosts(userId:Int)
    
  // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .users:
            return .GET
        case .posts:
            return .GET
        case .usersPosts(_):
            return .GET
        }
    }
    
  // compose the NetworkRequest
    func createRequest(token: String, environment: AppEnvironment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        //headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
   //encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .users:
            return nil
        case .posts:
            return nil
        case .usersPosts( _):
            return nil
        }
    }
    
  // compose urls for each request
    func getURL(from environment: AppEnvironment) -> String {
        let baseUrl = environment.baseURl
        switch self {
        case .users:
            return "\(baseUrl)/users"
        case .posts:
            return "\(baseUrl)/posts"
        case .usersPosts(let userId):
            return "\(baseUrl)/users/\(userId)/posts"
        }
    }
}
