//
//  UsersServices.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 8/5/22.
//
import Foundation
import Combine



class UserService: UsersGetable {
    
    private var networkRequest: Requestable
    private var environment: AppEnvironment = .development
    
  // inject this for testability
    init(networkRequest: Requestable, environment: AppEnvironment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getUsers() -> AnyPublisher<[UserModel], NetworkError> {
        let endPoint = AppEndpoints.users
        let request = endPoint.createRequest(token: "", environment: self.environment)
        return self.networkRequest.request(request)
    }
  
}
