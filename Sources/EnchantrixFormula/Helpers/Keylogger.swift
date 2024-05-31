//
//  Keylogger.swift
//
//
//  Created by MarkG on 31/5/24.
//

import Combine

public protocol Keylogger {

    var event: PassthroughSubject<KeyloggerEvent?, Never> { get }

    func start()
}


public struct KeyloggerEvent {

    public let key: HIDKeyboardUsage
    public let isCommandKeyPressed: Bool

    public init(key: HIDKeyboardUsage, isCommandKeyPressed: Bool) {
        self.key = key
        self.isCommandKeyPressed = isCommandKeyPressed
    }
}
