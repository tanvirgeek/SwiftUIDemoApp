//
//  MockData.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation

extension UserModel{
    static var mockUsers:[UserModel]{
        Bundle.main.decode([UserModel].self, from: "Users.json")
    }
    static var mockSingleUser:UserModel{
        self.mockUsers[0]
    }
}

extension PostModel{
    static var mockPosts:[PostModel]{
        Bundle.main.decode([PostModel].self, from: "Posts.json")
    }
    static var mockSinglePost:PostModel{
        self.mockPosts[0]
    }
    static var mockSingleUsersPostsArray:[PostModel]{
        self.mockPosts.filter({$0.userID == 1})
    }
}
