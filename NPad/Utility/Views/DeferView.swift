//
//  DeferView.swift
//  NPad
//
//  Created by Jason on 5/1/2024.
//

import SwiftUI

/// Defer view creation and only intialise view when body is rendered
///
struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
    }
}
