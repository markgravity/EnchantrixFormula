//
//  ShortcutField.swift
//
//
//  Created by MarkG on 22/6/24.
//

import SwiftUI
import ShortcutRecorderSwiftUI

public typealias Shortcutx = ShortcutRecorderSwiftUI.Shortcut

public struct ShortcutField<Label: View>: View {

    @Binding var shortcut: Shortcut
    let rule: Shortcut.Rule
    let label: () -> Label

    public var body: some View {
        HStack {
            label()
            Spacer()
            RecorderControl(
                shortcut: $shortcut,
                rule: rule
            )
            .fixedSize()
        }
    }

    public init(
        shortcut: Binding<Shortcut>,
        rule: Shortcut.Rule = .none,
        @ViewBuilder label: @escaping () -> Label
    ) {
        _shortcut = shortcut
        self.rule = rule
        self.label = label
    }

    public init(
        _ label: String,
        shortcut: Binding<Shortcut>,
        rule: Shortcut.Rule = .none
    ) where Label == Text {
        _shortcut = shortcut
        self.rule = rule
        self.label = {
            Text(label)
        }
    }
}

extension Shortcut: FormulaSettingItemValuable {}

public extension Shortcut {

    var key: KeyEvent.Key {
        .init(carbonKeyCode: carbonKeyCode)!
    }
}
