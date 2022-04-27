//
//  UserCard.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import SwiftUI

struct UserCard: View {
    var name:String
    var city:String
    var userId:Int
    var body: some View {
        NavigationLink {
            PostListView(userId: userId)
        } label: {
            VStack(alignment: .leading, spacing: 5){
                Text(name)
                    .font(.title)
                    .foregroundColor(AppColors.black)
                Text(city)
                    .font(.footnote)
                    .foregroundColor(AppColors.black)
            }
        }
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserCard(name: "Tanvir", city: "Jamalpur", userId: 1)
                .previewLayout(.sizeThatFits)
            UserCard(name: "Tanvir", city: "Jamalpur", userId: 1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
