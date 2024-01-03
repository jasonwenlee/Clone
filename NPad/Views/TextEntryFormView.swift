//
//  TextEntryFormView.swift
//  NPad
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
    @State private var showDeleteConfirmationAlert: Bool = false

    private var localTitle: String {
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var localDescription: String {
        return description.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var isUpdate: Bool {
        let existingTitle = selectedEntry?.entry_title?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let existingDescription = selectedEntry?.entry_description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if selectedEntry == nil || (localTitle.isEmpty && localDescription.isEmpty) {
            return false
        }

        if localTitle != existingTitle || localDescription != existingDescription {
            return true
        }

        return false
    }

    private var isAdd: Bool {
        return (!localTitle.isEmpty || !localDescription.isEmpty) && selectedEntry == nil
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
            CustomMenu(
                options: selectedEntry == nil ? [
                    MenuOption(selectionName: .addAttachment, onSelect: {}),
                ] : [
                    MenuOption(selectionName: .addAttachment, onSelect: {}),
                    MenuOption(selectionName: .delete, onSelect: { showDeleteConfirmationAlert = true }),
                ]
            )

            if isUpdate || isAdd {
                Button("Done", action: {
                    if isUpdate {
                        if let id = selectedEntry?.id {
                            viewModel.updateTextEntry(
                                id: id,
                                title: title,
                                description: description
                            )
                        }
                    } else if isAdd {
                        viewModel.addTextEntry(
                            title: title,
                            description: description
                        )
                        title = ""
                        description = ""
                    }

                    dismiss()
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(selectedEntry != nil ? "Edit Entry" : "New Entry")
        .alert("Confirm Deletion", isPresented: $showDeleteConfirmationAlert) {
            Button("Yes", role: .destructive, action: {
                if let entry = selectedEntry {
                    viewModel.deleteTextEntry(entry: entry)
                    dismiss()
                }
            })
            Button("No", role: .cancel, action: {})
        } message: {
            Text("Are you sure you want to delete this entry?")
        }
    }
}
