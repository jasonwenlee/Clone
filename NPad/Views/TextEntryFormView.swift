//
//  TextEntryFormView.swift
//  NPad
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntryFormView: View {
    var selectedEntry: TextEntry?

    private var textEntryViewModel: TextEntryFormViewModel = EntriesController.shared.textEntryFormViewModel
    @StateObject private var filePickerController = DocumentPickerController()
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var description: String
    @State private var existingAttachmentURLs: [URL]
    @State private var newAttachmentURLs: [URL]
    @State private var showDeleteConfirmationAlert: Bool = false

    private var localTitle: String {
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var localDescription: String {
        return description.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var allAttachmentURLs: [URL] {
        var all: [URL] = []
        all.append(contentsOf: existingAttachmentURLs)
        all.append(contentsOf: newAttachmentURLs)
        return all
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
        _existingAttachmentURLs = State(initialValue: self.selectedEntry?.attachmentURLs ?? [])
        _newAttachmentURLs = State(initialValue: [])
        Log.log(message: "Initialised text entry form")
    }

    var body: some View {
        Color.backgroundColour.ignoresSafeArea().overlay {
            VStack(alignment: .leading) {
                CustomTitleField(content: $title, placeHolder: "Title")
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))

                CustomDescriptionField(content: $description, placeholderDescription: "Tap to enter description")

                Spacer()

                if !allAttachmentURLs.isEmpty {
                    ScrollView(.horizontal) {
                        HStack(spacing: 8) {
                            ForEach(allAttachmentURLs.indices, id: \.self) { index in
                                CustomThumbnailView(attachmentURL: allAttachmentURLs[index])
                            }
                        }
                    }.padding([.horizontal], 5)
                }
            }
            .padding()
            .toolbar {
                CustomMenu(
                    options: selectedEntry == nil ? [
                        MenuOption(selectionName: .addAttachment, onSelect: { filePickerController.openDocumentPicker() }),
                    ] : [
                        MenuOption(selectionName: .addAttachment, onSelect: { filePickerController.openDocumentPicker() }),
                        MenuOption(selectionName: .delete, onSelect: { showDeleteConfirmationAlert = true }),
                    ]
                )

                if isUpdate || isAdd || !newAttachmentURLs.isEmpty {
                    Button("Done", action: {
                        if isUpdate {
                            Log.log(message: "Updating entry")
                            if let id = selectedEntry?.id {
                                textEntryViewModel.updateTextEntry(
                                    id: id,
                                    title: title,
                                    description: description
                                )
                            }
                        } else if isAdd {
                            Log.log(message: "Adding new entry")
                            textEntryViewModel.addTextEntry(
                                title: title,
                                description: description
                            )

                            title = ""
                            description = ""
                        }

                        if !newAttachmentURLs.isEmpty {
                            Log.log(message: "Adding new attachments for current entry")
                            textEntryViewModel.addAttachments(id: selectedEntry?.id ?? nil, urls: newAttachmentURLs)
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
                        textEntryViewModel.deleteTextEntry(entry: entry)
                        dismiss()
                    }
                })
                Button("No", role: .cancel, action: {})
            } message: {
                Text("Are you sure you want to delete this entry?")
            }.onChange(of: $filePickerController.urls.wrappedValue) {
                newAttachmentURLs.append(contentsOf: filePickerController.urls)
            }
        }
    }
}
