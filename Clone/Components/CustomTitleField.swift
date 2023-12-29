//
//  CustomTextField.swift
//  Clone
//
//  Created by Jason on 29/12/2023.
//

import SwiftUI

struct CustomTitleField: View {
    @Binding var content: String
    var placeHolder: String

    var body: some View {
        TextField(placeHolder, text: $content, axis: .vertical)
            .font(.title)
            .bold()
    }
}
