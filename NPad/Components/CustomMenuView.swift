//
//  CustomPicker.swift
//  NPad
//
//  Created by Jason on 2/1/2024.
//

import SwiftUI

/// - Parameters:
///   - options: Takes in a list of [PickerSelection]
struct CustomMenu: View {
    var options: [MenuOption]

    var body: some View {
        Menu {
            ForEach(options, id: \.self.selectionName) { option in
                Button(
                    role: option.selectionName == Selection.delete ? .destructive : nil,
                    action: option.onSelect,
                    label: {
                        HStack {
                            Text(option.selectionName.rawValue)
                            Spacer()
                            switch option.selectionName {
                            case .addAttachment:
                                Image(systemName: "rectangle.stack.badge.plus")
                            case .delete:
                                Image(systemName: "trash")
                            }
                        }
                    }
                )
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

/// - Parameters:
///   - selectionName: Accepts a value from [Selection].
///   - onSelect: A  callback to handle menu selection.
struct MenuOption {
    var selectionName: Selection
    var onSelect: () -> Void
}

enum Selection: String {
    case addAttachment = "Add Attachment"
    case delete = "Delete"
}
