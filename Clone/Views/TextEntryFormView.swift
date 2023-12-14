//
//  TextEntryFormView.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntryFormView: View {
    @Environment(\.dismiss) private var dismiss

    private var viewModel: TextEntryFormViewModel = EntriesController.shared.textEntryFormViewModel

    var selectedEntry: TextEntry?

    @State private var title = ""
    @State private var description = ""

    init(selectedEntry: TextEntry? = nil) {
        self.selectedEntry = selectedEntry
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if selectedEntry == nil {
                        Text("New entry").font(.headline)
                    } else {
                        Button("Cancel", action: {
                            dismiss()
                        })
                    }

                    Spacer()

                    if selectedEntry == nil {
                        Button("Add", action: {
                            viewModel.addTextEntry(title, description)
                            title = ""
                            description = ""
                        })
                    } else {
                        Button("Update", action: {
                            dismiss()
                        })
                    }
                }

                TextField("Title", text: $title)
                    .font(.title)
                    .padding(.vertical, 10)

                TextField("Description", text: $description)
                    .font(.body)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding()
            .onAppear {
                if let t = selectedEntry?.entry_title {
                    title = t
                }
                if let d = selectedEntry?.entry_description {
                    description = d
                }
            }
        }
    }
}
