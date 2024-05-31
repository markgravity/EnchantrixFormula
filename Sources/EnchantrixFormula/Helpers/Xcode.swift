//
//  Xcode.swift
//
//
//  Created by MarkG on 31/5/24.
//

import Foundation
import Cocoa

public protocol Xcode {
    
    var element: AXUIElement? { get }
    var isFocused: Bool { get }
    var sourceEditor: AXUIElement? { get }
}
