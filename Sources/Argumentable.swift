//
//  Argumentable.swift
//
//
//  Created by MarkG on 16/6/24.
//

import Foundation

public protocol Argumentable {

    var argumentDefinitions: [ArgumentDefinition] { get }

    func setArguments(_ args: Arguments)
}

public struct ArgumentDefinition: Hashable, Identifiable, Equatable {

    public static let manual = Self.init(
        name: "__manual__",
        connection: nil,
        isRequired: false
    )

    public static let requiredManual = Self.init(
        name: "__manual__",
        connection: nil,
        isRequired: true
    )

    public var id: String { name }

    public let name: String
    public let connection: String?
    public let isRequired: Bool

    public var requiresValue: Bool {
        connection != nil || self == .manual
    }

    public init(name: String, connection: String?, isRequired: Bool) {
        self.name = name
        self.connection = connection
        self.isRequired = isRequired
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public static func optional(name: String, connection: String? = nil) -> Self {
        .init(name: name, connection: connection, isRequired: false)
    }

    public static func required(name: String, connection: String? = nil) -> Self {
        .init(name: name, connection: connection, isRequired: true)
    }


}

public struct Arguments: Sequence {

    private var data: [ArgumentDefinition: String] = [:]

    public init() {}


    public func makeIterator() -> [ArgumentDefinition: String].Iterator {
        data.makeIterator()
    }

    public subscript(definition: ArgumentDefinition) -> String? {
        get {
            data[definition]
        }
        set(newValue) {
            data[definition] = newValue
        }
    }

    public func validate(on definitions: [ArgumentDefinition]) -> [ArgumentDefinition] {
        definitions.filter { $0.isRequired }
            .difference(
                other: data
                    .filter {
                        $0.key.isRequired && !$0.value.isEmpty
                    }.keys
                    .map { $0 as ArgumentDefinition }
            )
    }
}

public extension Array where Element == ArgumentDefinition {

    mutating func distinctAppend(_ object: Element) {
        guard !contains(object) else { return }
        append(object)
    }
}

private extension Array where Element: Hashable {

    func difference(other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
