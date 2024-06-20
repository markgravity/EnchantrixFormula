//
//  EventBus.swift
//
//
//  Created by MarkG on 20/6/24.
//

import Foundation
import AppKit

public protocol EventBus {

    func register(
        for target: Target,
        keyEventWith key: KeyEvent.Key,
        modifiers: NSEvent.ModifierFlags,
        isPassthrough: Bool,
        handler: @escaping (KeyEvent) -> Void
    ) -> String

    func register(
        for target: Target,
        mouseEventWith key: MouseEvent.Key,
        modifiers: NSEvent.ModifierFlags,
        handler: @escaping (MouseEvent) -> Void
    ) -> String

    func unregister(with id: String)
}
