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
    @State private var attachments: [Attachment]
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
        _attachments = State(initialValue: self.selectedEntry?.attachmentsArray ?? [])
        Log.log(message: "Initialised text entry form")
    }

    var body: some View {
        VStack(alignment: .leading) {
            CustomTitleField(content: $title, placeHolder: "Title")
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))

            CustomDescriptionField(content: $description, placeholderDescription: "Tap to enter description")

            Spacer()
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

            if isUpdate || isAdd {
                Button("Done", action: {
                    if isUpdate {
                        if let id = selectedEntry?.id {
                            textEntryViewModel.updateTextEntry(
                                id: id,
                                title: title,
                                description: description
                            )
                        }
                    } else if isAdd {
                        textEntryViewModel.addTextEntry(
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
                    textEntryViewModel.deleteTextEntry(entry: entry)
                    dismiss()
                }
            })
            Button("No", role: .cancel, action: {})
        } message: {
            Text("Are you sure you want to delete this entry?")
        }.onChange(of: $filePickerController.urls.wrappedValue) {
            let newAttachments = textEntryViewModel.addAttachments(id: selectedEntry?.id, urls: $filePickerController.urls.wrappedValue)
            attachments.append(contentsOf: newAttachments)
        }

        if !attachments.isEmpty {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(attachments) { attachment in
                        CustomThumbnailView(attachment: attachment)
                            .onTapGesture {
                                if let filePath = attachment.filePath {
                                    let coordinator = NSFileCoordinator()
                                    coordinator.coordinate(readingItemAt: filePath, options: .withoutChanges, error: nil) { _ in
                                        if UIApplication.shared.canOpenURL(filePath) {
                                            Log.log(message: "Can open file")
                                            UIApplication.shared.open(filePath, options: [:], completionHandler: { success in
                                                if !success {
                                                    Log.log(message: "Failed to open file")
                                                }
                                            })
                                        } else {
                                            Log.log(message: "Cannot open file: \(filePath)")
                                        }
                                    }
                                }
                            }
                    }
                }
            }.padding([.horizontal], 10)
        }
    }
}
