//
//  View.swift
//
//
//  Created by MarkG on 21/6/24.
//

import SwiftUI

public extension View {

    @ViewBuilder
    func `if`<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func ifLet<Content: View, T>(
        _ conditional: T?,
        @ViewBuilder _ content: (Self, _ value: T) -> Content
    ) -> some View {
        if let value = conditional {
            content(self, value)
        } else {
            self
        }
    }
}
