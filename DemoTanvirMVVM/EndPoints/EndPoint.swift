//
//  EndPoint.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation


// OLD WAY, Check better way in AppEndpoints file
enum EndPoint {
    case Base,users,posts,usersPosts(userId:Int)
}

class EndPointSouce {
    
    static func getEndPoint(type:EndPoint) -> String {
        switch type {
        case .Base:
            return "https://jsonplaceholder.typicode.com"
        case .users:
            return EndPointSouce.getEndPoint(type: .Base) + "/users"
        case .posts:
            return EndPointSouce.getEndPoint(type: .Base) + "/posts"
        case .usersPosts(userId: let userId):
            return EndPointSouce.getEndPoint(type: .Base) + "/users/\(userId)/posts"
        }
    }
    
    static var basicHeaders = ["Content-Type":"application/json", "Accept":"application/json"]

    static func CustomHeaders() -> [String:String] {
        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
        //let CustomHeaders = ["Authorization":"Bearer \(token)",
                             //"Content-Type":"application/json",
                             //"Accept":"application/json"]
        let CustomHeaders = ["Content-Type":"application/json",
                             "Accept":"application/json"]
        return CustomHeaders
    }

//    static func MultiPartCustomHeaders() -> [String:String] {
//        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
//        let multiPartCustomHeaders = [//"Authorization":"Bearer \(token)",
//                                      "Content-Type":"multipart/form-data",
//                                      "Accept":"application/json"]
//        return multiPartCustomHeaders
//    }
    
}
