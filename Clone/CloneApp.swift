//
//  CloneApp.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

@main
struct CloneApp: App {
    let persistenceController = PersistenceController.shared
    let entriesController = EntriesController()

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(entriesController)
        }
    }
}
