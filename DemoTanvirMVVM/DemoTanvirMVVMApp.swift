//
//  DemoTanvirMVVMApp.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import SwiftUI

@main
struct DemoTanvirMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UserDefaults.standard.set(false, forKey: "_UIConstrainedBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
