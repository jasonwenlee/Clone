//
//  ContentView.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntriesView: View {
    @ObservedObject var viewModel: TextEntriesViewModel

    var body: some View {
        NavigationView {
            VStack {
                List($viewModel.textEntries) { entry in
                    if let text = entry.entry_title.wrappedValue {
                        Text(text)
                    }
                }
                .navigationTitle("Text Entries")
            }
        }
    }
}

#Preview {
    TextEntriesView(
        viewModel: TextEntriesViewModel()
    )
}
