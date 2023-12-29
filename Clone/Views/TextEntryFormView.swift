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

    @State private var title: String
    @State private var description: String
    @State private var forceFocus: Bool

    private var localTitle: String {
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var localDescription: String {
        return description.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var toggleUpdateButtonState: Bool {
        let existingTitle = selectedEntry?.entry_title?.trimmingCharacters(in: .whitespacesAndNewlines)
        let existingDescription = selectedEntry?.entry_description?.trimmingCharacters(in: .whitespacesAndNewlines)

        return (localTitle == existingTitle && localDescription == existingDescription)
            || (localTitle.isEmpty && localDescription.isEmpty)
    }

    private var toggleAddButtonState: Bool {
        return localTitle.isEmpty && localDescription.isEmpty
    }

    init(selectedEntry: TextEntry? = nil) {
        self.selectedEntry = selectedEntry
        _title = State(initialValue: self.selectedEntry?.entry_title ?? "")
        _description = State(initialValue: self.selectedEntry?.entry_description ?? "")
        _forceFocus = State(initialValue: false)
    }

    var body: some View {
        VStack(alignment: .leading) {
            CustomTitleField(content: $title, placeHolder: "Title")
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))

            CustomDescriptionField(description: $description,
                                   placeholderDescription: "Tap to enter description")

            Spacer()
        }
        .padding()
        .toolbar {
            Image(systemName: "ellipsis")
            if selectedEntry != nil {
                Button("Update", action: {
                    if let id = selectedEntry?.id {
                        viewModel.updateTextEntry(
                            id: id,
                            title: title,
                            description: description
                        )
                    }
                    dismiss()
                }).disabled(toggleUpdateButtonState)
            } else {
                Button("Add", action: {
                    viewModel.addTextEntry(
                        title: title,
                        description: description
                    )
                    title = ""
                    description = ""
                    dismiss()
                }).disabled(toggleAddButtonState)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(selectedEntry != nil ? "Edit Entry" : "New Entry")
    }
}

#Preview {
    TextEntryFormView()
}
