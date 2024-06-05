//
//  Xcode.swift
//
//
//  Created by MarkG on 31/5/24.
//

import ApplicationServices
import Cocoa

@objc public protocol Xcode {

    @objc var element: AXUIElement? { get }
    @objc var isFocused: Bool { get }
    @objc var sourceEditor: AXUIElement? { get }
    @objc var workspaceURL: URL? { get }
}
