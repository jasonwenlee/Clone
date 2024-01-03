//
//  NPadApp.swift
//  NPad
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

@main
struct NPad: App {
    var body: some Scene {
        WindowGroup {
            TextEntriesView()
                .tabItem {
                    Label("Entries", systemImage: "list.bullet")
                }
        }
    }
}
