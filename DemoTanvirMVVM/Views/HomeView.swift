//
//  HomeView.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentTopic:TopicModel?
    @State private var showDetail:Bool = false
    @Namespace var animation
    @State private var animateView:Bool = false
    @State private var scrollOffset : CGFloat = 0
    @State var largeHeader = true
    @State var scrollViewScrollable = false
    
    var body: some View {
        VStack(spacing:0){
            HeaderCard(largeHeader: $largeHeader)
                .padding(.bottom)
                .padding(.vertical, largeHeader ? 15 : 0)
                .animation(.easeInOut(duration: 0.5), value: largeHeader)
            
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:0){
                    ForEach(topics) { topic in
                        AppHomeCardButton(imageName: topic.bg, bannerTitle: topic.bannerTitle, title: topic.skillName, id: topic.id, namespace: animation){
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                currentTopic = topic
                                showDetail = true
                            }
                        }.scaleEffect(currentTopic?.id == topic.id && showDetail ? 1:0.93)
                            .offset(y:currentTopic?.id == topic.id && animateView ? safeArea().top : 0)
                            .opacity(showDetail ? (currentTopic?.id == topic.id ? 1:0):1)
                    }
                }.background(GeometryReader { geometryProxy -> Color in
                    if scrollViewScrollable {
                        DispatchQueue.main.async {
                            largeHeader = geometryProxy.frame(in: .named("1")).minY >= 0
                        }
                    }
                    return Color.clear
                })
                .background(
                    GeometryReader { proxy in
                        Color.clear.onAppear {
                            scrollViewScrollable = proxy.frame(in: .named("1")).size.height >= UIScreen.main.bounds.size.height - 100
                        }
                    }
                )
            }.coordinateSpace(name: "1")
            .opacity(showDetail ? 0 : 1)
            .overlay{
                if let currentTopic = currentTopic,showDetail {
                    DetailView(topic: currentTopic)
                        .ignoresSafeArea(.container,edges: .top)
                }
            }
            .navigationBarHidden(true)

        }
    }
    
    @ViewBuilder
    func HomeCardComponent(topic:TopicModel)->some View{
        VStack(alignment:.leading,spacing: 15){
            ZStack(alignment:.topLeading){
                GeometryReader{ proxy in
                    let size = proxy.size
                    Image(topic.logo)
                        .resizable()
                        .frame(width:size.width,height: size.height)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
                }.frame(height: 300)
                
                LinearGradient(colors: [.black.opacity(0.5),.black.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
            }
        }.background(alignment: .top, content: {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.gray)
        })
        .matchedGeometryEffect(id: topic.id, in: animation)
    }
    
    func DetailView(topic:TopicModel)->some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment:.leading){
                AppHomeDetail(imageName: topic.bg, bannerTitle: topic.bannerTitle, description: topic.SkillDescription, scrollOffset: $scrollOffset)
                    .scaleEffect(animateView ? 1 : 0.93)
            }.offset(y:scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .coordinateSpace(name: "SCROLL")
        .matchedGeometryEffect(id: topic.id, in: animation)
        .onAppear(){
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
        }
        
            .background(alignment: .top, content: {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(AppColors.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.bottom)
            })
       
        .overlay(alignment:.topTrailing,content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentTopic = nil
                    showDetail = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                
            }.padding()
                .padding(.top,safeArea().top)
                .offset(y:-10)
                .opacity(animateView ? 1:0)
            
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

