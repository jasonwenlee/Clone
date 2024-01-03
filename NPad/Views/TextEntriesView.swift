//
//  ContentView.swift
//  NPad
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntriesView: View {
    @ObservedObject var viewModel: TextEntriesViewModel = EntriesController.shared.textEntriesViewModel
    @State private var selectedEntry: TextEntry?
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Entries
                List($viewModel.textEntries) { entry in
                    if let title = entry.entry_title.wrappedValue {
                        NavigationLink {
                            TextEntryFormView(selectedEntry: entry.wrappedValue)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(title).font(.headline).foregroundStyle(.black)
                                Text(entry.entry_description.wrappedValue ?? "")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }.frame(height: 50)
                        }.listRowSeparator(.hidden)
                    }
                }
                .navigationTitle("Text Entries")

                // FAB
                NavigationLink {
                    TextEntryFormView()
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.regular))
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding()
            }
        }.searchable(text: $searchText)
    }
}
