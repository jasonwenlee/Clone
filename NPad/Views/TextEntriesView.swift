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
                List($viewModel.textEntries.filter { entry in
                    let s = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                    return s.isEmpty
                        || (entry.entry_title.wrappedValue?.localizedCaseInsensitiveContains(s) ?? false)
                        || (entry.entry_description.wrappedValue?.localizedCaseInsensitiveContains(s) ?? false)
                }) { entry in
                    if let title = entry.entry_title.wrappedValue,
                       let description = entry.entry_description.wrappedValue
                    {
                        NavigationLink {
                            TextEntryFormView(selectedEntry: entry.wrappedValue)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(title).font(.headline).foregroundStyle(.black)
                                Text(description)
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
