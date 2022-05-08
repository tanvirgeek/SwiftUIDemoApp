//
//  PostsService.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 8/5/22.
//

import Foundation
import Combine



class PostsService: PostsGetable {
    
    private var networkRequest: Requestable
    private var environment: AppEnvironment
    
  // inject this for testability
    init(networkRequest: Requestable, environment: AppEnvironment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getPosts() -> AnyPublisher<[PostModel], NetworkError> {
        let endPoint = AppEndpoints.posts
        let request = endPoint.createRequest(token: "", environment: self.environment)
        return self.networkRequest.request(request)
    }
    
  
}
