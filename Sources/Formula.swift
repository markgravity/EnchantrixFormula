// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine
import AppKit
import SwiftUI

public enum FormulaDependency {

    case keylogger,
         commandLineTool,
         overlay,
         eventBus
}

public protocol Formula {

    var id: String { get }
    var name: String { get }
    var description: String { get }
    var icon: NSImage? { get }
    var keywords: [String] { get }
}

public protocol Enchantable: Settingable {

    static var id: String { get }
    static var targets: [Target] { get }
    static var dependencies: [FormulaDependency] { get }

    init(target: Target, dependencies: [FormulaDependency: AnyObject])

    func enchant()
    func disenchant()
}

public protocol Activable {

    func active(on target: Target)
}

public extension Enchantable {

    var targets: [Target] {
        Self.targets
    }
}

public extension Formula where Self: Enchantable {

    var id: String { Self.id }
}

public extension Formula {

    var keywords: [String] { [] }
}
