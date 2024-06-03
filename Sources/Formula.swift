// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@objc public class FormulaDependency: NSObject {

    @objc public static let xcode = FormulaDependency(rawValue: 0)
    @objc public static let keylogger = FormulaDependency(rawValue: 1)

    let rawValue: Int

    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

@objc public protocol Formula {

    @objc static var id: String { get }
    @objc static var dependencies: [FormulaDependency] { get }

    @objc var title: String { get }
    @objc var description: String { get }
    @objc var icon: Data { get }

    @objc init(dependencies: [FormulaDependency: AnyObject])
    @objc func active()
    @objc func deactive()
}

@objc public protocol ActionFormula: Formula {

    @objc func excute()
}

public extension Formula {

    var id: String { Self.id }
}
