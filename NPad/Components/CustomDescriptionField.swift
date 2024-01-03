//
//  CustomDescriptionField.swift
//  NPad
//
//  Created by Jason on 29/12/2023.
//

import SwiftUI

struct CustomDescriptionField: View {
    @Binding var description: String
    var placeholderDescription: String

    @State private var hidePlaceHolderDescription = false
    @FocusState private var isFocusedOnDescriptionField: Bool

    var body: some View {
        ZStack {
            if hidePlaceHolderDescription {
                TextEditor(text: $description)
                    .font(.body)
                    .focused($isFocusedOnDescriptionField)

            } else {
                Text(placeholderDescription)
                    .foregroundStyle(.gray)
                    .padding(EdgeInsets(top: 10, leading: 6, bottom: 0, trailing: 6))
                    .font(.body)
                    .onTapGesture {
                        hidePlaceHolderDescription = true
                        isFocusedOnDescriptionField = true
                    }
            }
        }.onAppear {
            if !description.isEmpty {
                hidePlaceHolderDescription = true
            }
        }
    }
}
