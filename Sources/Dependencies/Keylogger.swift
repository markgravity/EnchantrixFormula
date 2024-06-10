//
//  Keylogger.swift
//
//
//  Created by MarkG on 31/5/24.
//

import Foundation

@objc public protocol Keylogger {

    func registerListener(for formula: Formula & Enchantable, onEvent: @escaping (KeyloggerEvent) -> Void)
    func unregisterListener(for formula: Formula)
}


@objc public class KeyloggerEvent: NSObject {

    @objc public let key: HIDKeyboardUsage
    @objc public let isCommandKeyPressed: Bool
    @objc public let isShiftKeyPressed: Bool
    @objc public let isControlKeyPressed: Bool
    @objc public let isOptionKeyPressed: Bool

    @objc public init(
        key: HIDKeyboardUsage,
        isCommandKeyPressed: Bool,
        isShiftKeyPressed: Bool,
        isControlKeyPressed: Bool,
        isOptionKeyPressed: Bool
    ) {
        self.key = key
        self.isCommandKeyPressed = isCommandKeyPressed
        self.isShiftKeyPressed = isShiftKeyPressed
        self.isControlKeyPressed = isControlKeyPressed
        self.isOptionKeyPressed = isOptionKeyPressed
    }
}
