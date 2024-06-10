// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine

@objc public class FormulaDependency: NSObject {

    @objc public static let xcode = FormulaDependency(rawValue: 0)
    @objc public static let keylogger = FormulaDependency(rawValue: 1)
    @objc public static let terminal = FormulaDependency(rawValue: 2)

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

@objc public protocol Enchantable {

    static var id: String { get }
    static var targets: [String] { get }
    static var dependencies: [FormulaDependency] { get }

    init(dependencies: [FormulaDependency: AnyObject])

    func enchant()
    func disenchant()
}

public protocol Activable {

    func active()
}

public extension Enchantable {

    var targets: [String] { Self.targets }
}
