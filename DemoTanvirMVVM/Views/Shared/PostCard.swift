//
//  PostCard.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import SwiftUI

struct PostCard: View {
    var title:String
    var description:String
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(title)
                .font(.title)
                .autocapitalization(.words)
            Text(description)
                .font(.body)
                .foregroundColor(AppColors.black)
        }
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCard(title: "Get all the foods", description: "We have to get all the foods from the sea We have to get all the foods from the sea")
                .previewLayout(.sizeThatFits)
            PostCard(title: "Get all the foods", description: "We have to get all the foods from the sea We have to get all the foods from the sea")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
