//
//  Keylogger.swift
//
//
//  Created by MarkG on 31/5/24.
//

import Foundation

@objc public protocol Keylogger {

    @objc func registerListener(for formula: Formula, onEvent: @escaping (KeyloggerEvent) -> Void)
    @objc func unregisterListener(for formula: Formula)
}


@objc public class KeyloggerEvent: NSObject {

    @objc public let key: HIDKeyboardUsage
    @objc public let isCommandKeyPressed: Bool

    @objc public init(key: HIDKeyboardUsage, isCommandKeyPressed: Bool) {
        self.key = key
        self.isCommandKeyPressed = isCommandKeyPressed
    }
}
