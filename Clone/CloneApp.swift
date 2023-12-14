//
//  CloneApp.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

@main
struct CloneApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                TextEntriesView()
                    .tabItem {
                        Label("Entries", systemImage: "list.bullet")
                    }
                TextEntryFormView()
                    .tabItem {
                        Label("Add Entry", systemImage: "square.and.pencil")
                    }
            }
        }
    }
}
