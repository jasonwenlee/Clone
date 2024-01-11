//
//  CustomDescriptionField.swift
//  NPad
//
//  Created by Jason on 29/12/2023.
//

import SwiftUI

struct CustomDescriptionField: View {
    @Binding var content: String
    var placeholderDescription: String

    @State private var hidePlaceHolderDescription = false
    @FocusState private var isFocusedOnDescriptionField: Bool

    var body: some View {
        ZStack {
            if hidePlaceHolderDescription {
                TextEditor(text: $content)
                    .font(.body)
                    .focused($isFocusedOnDescriptionField)
                    .autocorrectionDisabled()
                    .scrollContentBackground(.hidden)
                    .background(Color.backgroundColour.ignoresSafeArea())
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
            if !content.isEmpty {
                hidePlaceHolderDescription = true
            }
        }
    }
}
