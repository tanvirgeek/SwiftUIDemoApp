//
//  AppProtocols.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 8/5/22.
//

import Foundation
import Combine

public protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

protocol UsersGetable {
    func getUsers() -> AnyPublisher<[UserModel], NetworkError>
}

protocol PostsGetable {
    func getPosts() -> AnyPublisher<[PostModel], NetworkError>
}
