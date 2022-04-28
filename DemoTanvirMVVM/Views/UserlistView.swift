//
//  UserlistView.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 27/4/22.
//

import SwiftUI

struct UserlistView: View {
    // make forPreview to true for fixing UI issues in the preview
    @StateObject private var vm = HomeViewModel(forPreview: false)
    
    var body: some View {
        List(vm.users, id:\.id) { user in
            UserCard(name: user.name, city: user.address.city, userId: user.id)
        }.overlay {
            if vm.isLoading{
                ProgressView()
            }
        }
        .alert("Application Error", isPresented: $vm.showAlert, actions: {
            Button("OK"){}
        },message:{
            Text(vm.errorMessage)
        })
        .navigationTitle("Network Call, Users")
        .listStyle(.plain)
    }
}

struct UserlistView_Previews: PreviewProvider {
    static var previews: some View {
        UserlistView()
    }
}
