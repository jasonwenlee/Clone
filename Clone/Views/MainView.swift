//
//  MainView.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var controller: EntriesController

    var body: some View {
        TabView {
            TextEntriesView(
                viewModel: controller.textEntriesViewModel
            )
            .tabItem {
                Label("Entries", systemImage: "list.bullet")
            }
            TextEntryFormView(
                viewModel: controller.textEntryFormViewModel
            )
            .tabItem {
                Label("Add Entry", systemImage: "square.and.pencil")
            }
        }
    }
}

#Preview {
    MainView()
}
