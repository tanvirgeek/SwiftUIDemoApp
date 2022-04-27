//
//  PostListViewModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var vm = PostListViewModel(forPreview: false)
    var userId : Int?
    
    var body: some View {
        List(vm.posts, id:\.id) { post in
            PostCard(title: post.title, description: post.body)
        }.overlay(content: {
            if vm.isLoading{
                ProgressView()
            }
        }).alert("Application Error", isPresented: $vm.showAlert, actions: {
            Button("OK"){}
        },message:{
            Text(vm.errorMessage)
        })
        .navigationTitle("Posts")
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.userID = self.userId
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
