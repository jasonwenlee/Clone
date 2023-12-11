//
//  TextEntryFormView.swift
//  Clone
//
//  Created by Jason on 11/12/2023.
//

import SwiftUI

struct TextEntryFormView: View {
    var viewModel: TextEntryFormViewModel

    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("New entry")
                        .font(.headline)
                        .padding()

                    Spacer()

                    Button("Add", action: {
                        viewModel.addTextEntry(title, description)
                        title = ""
                        description = ""
                    }).padding()
                }

                TextField("Title", text: $title)
                    .font(.title)
                    .padding()

                TextField("Description", text: $description)
                    .font(.body)
                    .padding()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
    }
}

#Preview {
    TextEntryFormView(viewModel: TextEntryFormViewModel())
}
