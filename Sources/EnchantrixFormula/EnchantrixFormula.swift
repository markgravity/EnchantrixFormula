// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol EnchantrixFormula {

    static var id: String { get }

    var id: String { get }
    var title: String { get }
    var description: String { get }
    var icon: Data { get }

    func register()
    func unregister()
}

public protocol EnchantrixActionFormula: EnchantrixFormula {

    func excute()
}

public extension EnchantrixFormula {

    var id: String { Self.id }
}
