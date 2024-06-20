//
//  MouseEvent.swift
//  
//
//  Created by MarkG on 20/6/24.
//

import Foundation
import Carbon
import AppKit

public struct MouseEvent {

    public let target: Target
    public let key: Key
    public let modifiers: NSEvent.ModifierFlags
    public let position: CGPoint

    public init(
        target: Target,
        key: Key,
        modifiers: NSEvent.ModifierFlags,
        position: CGPoint
    ) {
        self.target = target
        self.key = key
        self.modifiers = modifiers
        self.position = position
    }
}

public extension MouseEvent {

    struct Listener: Equatable {

        public let id: String = UUID().uuidString
        public let target: Target
        public let key: Key
        public let modifiers: NSEvent.ModifierFlags
        public let handler: (MouseEvent) -> Void

        public init(
            target: Target,
            key: Key,
            modifiers: NSEvent.ModifierFlags,
            handler: @escaping (MouseEvent) -> Void
        ) {
            self.target = target
            self.key = key
            self.modifiers = modifiers
            self.handler = handler
        }

        public static func == (lhs: Listener, rhs: Listener) -> Bool {
            lhs.id == rhs.id
        }
    }
}


public extension MouseEvent {

    enum Key {

        case leftButtonUp
        case leftButtonDragging
    }

}

public extension NSEvent.ModifierFlags {

    init(flags: CGEventFlags) {
        self.init()

        if flags.contains(.maskShift) {
            insert(.shift)
        }

        if flags.contains(.maskControl) {
            insert(.control)
        }

        if flags.contains(.maskAlternate) {
            insert(.option)
        }

        if flags.contains(.maskCommand) {
            insert(.command)
        }

        if flags.contains(.maskHelp) {
            insert(.help)
        }

        if flags.contains(.maskSecondaryFn) {
            insert(.function)
        }
    }
}
