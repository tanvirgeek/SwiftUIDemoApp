//
//  HomeCardView.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 27/4/22.
//

import SwiftUI

struct AppHomeCardButton: View {
    var imageName:String
    var bannerTitle:String
    var title:String
    var id:String
    var namespace:Namespace.ID
    var pressed:()->Void
    var body: some View {
        Button {
            pressed()
        } label: {
            VStack(alignment:.leading,spacing: 15){
                ZStack(alignment:.topLeading){
                    GeometryReader{ proxy in
                        let size = proxy.size
                        Image(imageName)
                            .resizable()
                            .frame(width:size.width,height: size.height)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
                    }.frame(height: 300)
                    
                    LinearGradient(colors: [.black.opacity(0.5),.black.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
                }
            }
        }.buttonStyle(ScaleButtonStyle())
        .matchedGeometryEffect(id: id, in: namespace)
        
        
    }
}

struct AppHomeDetail: View {
    var imageName:String
    var bannerTitle:String
    var description:String
    @State var animateContent:Bool = false
    @Binding var scrollOffset : CGFloat
    var body: some View {
        
        VStack(alignment:.leading,spacing: 15){
            ZStack(alignment:.topLeading){
                GeometryReader{ proxy in
                    let size = proxy.size
                    Image(imageName)
                        .resizable()
                        .frame(width:size.width,height: size.height)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
                }.frame(height: 300)
                
                LinearGradient(colors: [.black.opacity(0.5),.black.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
            }
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
                .lineSpacing(10)
                //.offset(y:scrollOffset > 0 ? -scrollOffset:0)
            
            
        }.buttonStyle(ScaleButtonStyle())
        
        
    }
}

//struct AppHomeCardButton_Previews: PreviewProvider {
//    static func pressed(){
//        
//    }
//    static var previews: some View {
//        AppHomeCardButton(imageName: "mvvm", bannerTitle: "SwiftUI Wizard", title: "Love SwiftUI", id: "", namespace: <#Namespace.ID#>, pressed: pressed)
//    }
//}

struct ScaleButtonStyle:ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
