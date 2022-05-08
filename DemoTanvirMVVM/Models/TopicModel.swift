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
    TopicModel(skillName: "SwiftUI", SkillDescription: "I have been makin SwiftUI apps since 2020, with Local sotorage Coredata(Relational, Predicates), Firebase and Rest API. I am not only very passionate about swiftUI but also did the hours of practice everyday to master my skill for 2 years.TDD, POP, MVVM, Matched Geometry Effects, cool animations, Custom Shapes, Custom Buttons, Custom Pickers, UIView Representable, Bridging UIKit With SwiftUI and What not.", experience: "3 yrs", logo: "sw", bannerTitle: "SwiftUI Wizard", bg: "sw"),
    TopicModel(skillName: "MVVM", SkillDescription: " I took an Udemy course from a fortune five hundred software engineer. I learned MVVM architechture from him.", experience: "3 yrs", logo: "mvvmarc", bannerTitle: "MVVM Mastro", bg: "mvvmarc"),
    
    TopicModel(skillName: "TDD", SkillDescription: "Test Driven Development, Unit Testing, Dependency Injection and Mock Data for Preview, and Mock data in Preview Assets", experience: "3 yrs", logo: "TDD", bannerTitle: "Test Driven Development", bg: "TDD"),
    
    TopicModel(skillName: "FR",SkillDescription: "API integration with Combine, URLSession or Alamofire. Also I have worked with firebase for my many projects.", experience: "3 yrs", logo: "fr",  bannerTitle: "fr", bg: "fr"),
    TopicModel(skillName: "WWDC", SkillDescription: "Watching WWDC videos is one of my favourite passtime. I learned from apple developers which no one from youtube can teach me.", experience: "3 yrs", logo: "wwdc", bannerTitle: "WWDC lover", bg: "wwdc"),
    TopicModel(skillName: "Reusabe Components", SkillDescription: "I do not make large views. All my views consist of small components which are reusabel. I use previews all the time to change my design. Previews are for every views so I use mockdata for previews", experience: "3 yrs", logo: "rc", bannerTitle: "MVVM Mastro", bg: "rc"),
    TopicModel(skillName: "Async Await", SkillDescription: "Ever since the release of Async Await I use them. It makes codes readable and less hustle to understand. This is so cool", experience: "3 yrs", logo: "async", bannerTitle: "SwiftUI Wizard", bg: "async"),
    TopicModel(skillName: "Combine", SkillDescription: "I read combine documentation and books. I also practice network call with combine and use combine when necessary.", experience: "3 yrs", logo: "combine", bannerTitle: "Combine", bg: "combine"),
    TopicModel(skillName: "AR", SkillDescription: "I made augmented reality apps. I read apple developers code. I did and AR project for my previous company and they loved my works.", experience: "3 yrs", logo: "ar", bannerTitle: "AR", bg: "ar"),
    TopicModel(skillName: "Hire ME", SkillDescription: "You should hire me. I have over two years of experience and I am communicative and love music, guitar. I am very much concered about your projects.", experience: "3 yrs", logo: "hm", bannerTitle: "WWDC lover", bg: "hm"),
    TopicModel(skillName: "SP", SkillDescription: "We are commited to protect the planet by whatever we can do.", experience: "3 yrs", logo: "sp", bannerTitle: "sp", bg: "sp"),
]
