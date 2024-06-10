//
//  Configurable.swift
//  EnchantrixFormula
//
//  Created by MarkG on 10/6/24.
//

import Foundation
import Combine
import SwiftUI

public protocol Configurable {

    var settings: any FormulaSettings { get }
    var settingsView: AnyView { get }
}

public protocol FormulaSettings: ObservableObject {

//    func save()
//    func load()
}

@propertyWrapper
public struct FormulaSettingItem<Value> {

    public var wrappedValue: Value {
        willSet {  // Before modifying wrappedValue
            publisher.subject.send(newValue)
        }
    }

    public var projectedValue: Publisher {
        publisher
    }

    private var publisher: Publisher

    public struct Publisher: Combine.Publisher {

        public typealias Output = Value
        public typealias Failure = Never

        var subject: CurrentValueSubject<Value, Never> // PassthroughSubject will lack the call of initial assignment

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            subject.subscribe(subscriber)
        }

        init(_ output: Output) {
            subject = .init(output)
        }
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
    }

    public static subscript<OuterSelf: ObservableObject>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value {
        get {
            let value = observed[keyPath: storageKeyPath].wrappedValue
            let userDefaults = getUserDefaults(for: observed)
            let key = getKey(for: observed, wrappedKeyPath: wrappedKeyPath)
            if let storedValue = userDefaults.value(forKey: key) as? Value {
                return storedValue
            }
            
            userDefaults.set(value, forKey: key)
            return value
        }
        set {
            if let subject = observed.objectWillChange as? ObservableObjectPublisher {
                subject.send() // Before modifying wrappedValue
                observed[keyPath: storageKeyPath].wrappedValue = newValue
                let userDefaults = getUserDefaults(for: observed)
                let key = getKey(for: observed, wrappedKeyPath: wrappedKeyPath)
                userDefaults.set(newValue, forKey: key)
            }
        }
    }


    static private func getModuleName<OuterSelf: ObservableObject>(for observed: OuterSelf) -> String {
        String(
            String(reflecting: observed.self)
                .split(separator: ".")
                .first!
        )
    }

    static private func getKey<OuterSelf: ObservableObject>(
        for observed: OuterSelf,
        wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>
    ) -> String {
        String(reflecting: wrappedKeyPath)
            .split(separator: ".")
            .dropFirst()
            .joined(separator: ".")
    }

    static private func getUserDefaults<OuterSelf: ObservableObject>(for observed: OuterSelf) -> UserDefaults {
        let name = getModuleName(for: observed)
        return .init(suiteName: name)!
    }
}

