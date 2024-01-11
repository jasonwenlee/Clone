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
                            DeferView {
                                TextEntryFormView(selectedEntry: entry.wrappedValue)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                title.isEmpty ? Text("No title")
                                    .font(.headline)
                                    .italic()
                                    .foregroundStyle(.gray) :
                                    Text(title).font(.headline)
                                description.isEmpty ? Text("No description")
                                    .font(.subheadline)
                                    .italic()
                                    .foregroundStyle(.gray) :
                                    Text(description).font(.subheadline)
                            }.frame(height: 50)
                        }.listRowSeparator(.hidden)
                    } else {
                        if !entry.wrappedValue.attachmentURLs.isEmpty {
                            NavigationLink {
                                DeferView {
                                    TextEntryFormView(selectedEntry: entry.wrappedValue)
                                }
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("No title")
                                        .font(.headline)
                                        .italic()
                                        .foregroundStyle(.gray)
                                    Text("No description")
                                        .font(.subheadline)
                                        .italic()
                                        .foregroundStyle(.gray)
                                }.frame(height: 50)
                            }.listRowSeparator(.hidden)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Text Entries")
                .background(Color.backgroundColour.ignoresSafeArea())

                // FAB
                NavigationLink {
                    DeferView {
                        TextEntryFormView()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.regular))
                        .padding()
                        .background(Color.primaryActionColour)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding()
            }
        }.searchable(text: $searchText)
    }
}
