// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine
import AppKit
import SwiftUI

@objc public class FormulaDependency: NSObject {

    @objc public static let keylogger = FormulaDependency(rawValue: 0)
    @objc public static let commandLineTool = FormulaDependency(rawValue: 1)
    @objc public static let overlayInjector = FormulaDependency(rawValue: 2)

    let rawValue: Int

    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

@objc public protocol Formula {

    @objc var id: String { get }
    @objc var name: String { get }
    @objc var description: String { get }
    @objc var icon: NSImage? { get }
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
