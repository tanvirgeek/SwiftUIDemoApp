//
//  MockUserService.swift
//  DemoTanvirMVVMTests
//
//  Created by Tanvir Alam on 8/5/22.
//

import Foundation
import Combine

@testable import DemoTanvirMVVM

class MockUsersService:UsersGetable{
    func getUsers() -> AnyPublisher<[UserModel], NetworkError> {
        Just(UserModel.mockUsers)
            .tryMap { users in
                guard !users.isEmpty else{
                    throw NetworkingError.nodataAvailable
                }
                return users
            }
            //.receive(on: DispatchQueue.main)
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}

class MockPostsService:PostsGetable{
    func getPosts() -> AnyPublisher<[PostModel], NetworkError> {
        Just(PostModel.mockPosts)
            .tryMap { posts in
                guard !posts.isEmpty else{
                    throw NetworkingError.nodataAvailable
                }
                return posts
            }
            //.receive(on: DispatchQueue.main)
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}

