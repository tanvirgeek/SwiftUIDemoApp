//
//  PostModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation

//https://jsonplaceholder.typicode.com/posts
//https://jsonplaceholder.typicode.com/users/1/posts

// MARK: - PostModel
struct PostModel: Codable,Identifiable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
