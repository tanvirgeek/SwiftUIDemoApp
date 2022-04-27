//
//  TopicsModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 27/4/22.
//

import Foundation

struct TopicModel:Identifiable{
    let id = UUID().uuidString
    let skillName:String
    let SkillDescription:String
    let experience:String
    let logo:String
    let bannerTitle:String
    let bg:String
}

let topics:[TopicModel] = [
    TopicModel(skillName: "SwiftUI", SkillDescription: "I make custom animation. Reusable Components. Matched Geometry Effect", experience: "3 yrs", logo: "SwiftUI", bannerTitle: "SwiftUI Wizard", bg: "SwiftUI"),
    TopicModel(skillName: "MVVM", SkillDescription: "I follow MVVM Architechture", experience: "3 yrs", logo: "MVVM", bannerTitle: "MVVM Mastro", bg: "mvvm-1"),
    TopicModel(skillName: "Components", SkillDescription: "I make Small Components", experience: "3 yrs", logo: "components", bannerTitle: "SwiftUI Wizard", bg: "components"),
    TopicModel(skillName: "Swift", SkillDescription: "Read Swift Documentation", experience: "3 yrs", logo: "swift", bannerTitle: "Swift is my one true love", bg: "swift"),
    TopicModel(skillName: "Async Await", SkillDescription: "Async await network calls sinch iOS 15", experience: "2 years", logo: "async", bannerTitle: "Async Await is Awesome", bg: "async"),
    TopicModel(skillName: "Hire Me Please", SkillDescription: "You should hire me because your will love to work with me", experience: "3 yrs", logo: "hireme", bannerTitle: "Hire Me", bg: "hireme")
]
