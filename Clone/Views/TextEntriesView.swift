//
//  ContentView.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntriesView: View {
    @ObservedObject var viewModel: TextEntriesViewModel = EntriesController.shared.textEntriesViewModel
    @State private var selectedEntry: TextEntry?

    var body: some View {
        NavigationView {
            VStack {
                List($viewModel.textEntries) { entry in
                    if let title = entry.entry_title.wrappedValue {
                        Text(title).onTapGesture {
                            selectedEntry = entry.wrappedValue
                        }
                    }
                }
                .navigationTitle("Text Entries")
                .sheet(item: $selectedEntry) { e in
                    TextEntryFormView(selectedEntry: e)
                }
            }
        }
    }
}
