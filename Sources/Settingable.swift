//
//  Settingable.swift
//  EnchantrixFormula
//
//  Created by MarkG on 10/6/24.
//

import Foundation
import Combine
import SwiftUI

public protocol Settingable {

    var target: Target { get }
    var settings: FormulaSettings { get }
    var settingsView: AnyView? { get }
}

public extension Settingable {

    var settingsView: AnyView? { nil }
}

open class FormulaSettings: NSObject, ObservableObject {

    fileprivate lazy var bundleID: String = {
        let bundle = Bundle.init(for: type(of: self))
        guard let bundleID = bundle.infoDictionary?["CFBundleIdentifier"] as? String else {
            fatalError("Unable to get CFBundleIdentifier")
        }
        return bundleID
    }()

    fileprivate lazy var userDefaults: UserDefaults = {
        .init(suiteName: bundleID)!
    }()

    public let formula: Formula & Settingable

    @FormulaSettingItem 
    public var isEnchanted: Bool = true

    required public init(formula: Formula & Settingable) {
        self.formula = formula

    }

    func clear() {
        userDefaults.removeSuite(named: bundleID)
        userDefaults.synchronize()
    }
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
    private var valueGetter: (UserDefaults, String) -> Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
        valueGetter = { userDefault, key in
            return userDefault.value(forKey: key) as? Value ?? wrappedValue
        }
    }

    public init(wrappedValue: Value) where Value: RawRepresentable {
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
        valueGetter = { userDefault, key in
            guard let data = userDefault.value(forKey: key) as? Value.RawValue,
                  let value = Value(rawValue: data) else {
                return wrappedValue
            }

            return value
        }
    }

    public init(wrappedValue: Value) where Value: FormulaSettingItemValuable {
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
        valueGetter = { userDefault, key in
            guard let data = userDefault.value(forKey: key) as? Data,
                  let value = try? JSONDecoder().decode(Value.self, from: data) else {
                return wrappedValue
            }

            return value
        }
    }

    public static subscript<OuterSelf: FormulaSettings>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value {
        get {
            let userDefaults = getUserDefaults(for: observed)
            let key = getKey(for: observed, wrappedKeyPath: wrappedKeyPath)
            return observed[keyPath: storageKeyPath].valueGetter(userDefaults, key)
        }
        set {
            observed.objectWillChange.send()
            observed[keyPath: storageKeyPath].wrappedValue = newValue
            
            let userDefaults = getUserDefaults(for: observed)
            let key = getKey(for: observed, wrappedKeyPath: wrappedKeyPath)

            if let data = newValue as? (any RawRepresentable) {
                userDefaults.set(data.rawValue, forKey: key)
                return
            }

            if let encodable = newValue as? FormulaSettingItemValuable,
               let data = try? JSONEncoder().encode(encodable) {
                userDefaults.set(data, forKey: key)
                return
            }

            userDefaults.set(newValue, forKey: key)
        }
    }

    static private func getModuleName<OuterSelf: FormulaSettings>(for observed: OuterSelf) -> String {
        String(
            String(reflecting: observed.self)
                .split(separator: ".")
                .first!
        )
    }

    static private func getKey<OuterSelf: FormulaSettings>(
        for observed: OuterSelf,
        wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>
    ) -> String {
        String(reflecting: wrappedKeyPath)
            .split(separator: ".")
            .dropFirst()
            .joined(separator: ".")
    }

    static private func getUserDefaults<OuterSelf: FormulaSettings>(for observed: OuterSelf) -> UserDefaults {
        observed.userDefaults
    }
}


extension FormulaSettingItem {

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
}

public protocol FormulaSettingItemValuable: Codable {}

extension Array: RawRepresentable where Element: Codable {

    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

extension Dictionary: RawRepresentable where Key: Codable, Value: Codable {
    
    public init?(rawValue: Data) {
        let decoder = JSONDecoder()
        guard let dictionary = try? decoder.decode([Key: Value].self, from: rawValue) else {
            return nil
        }
        self = dictionary
    }

    public var rawValue: Data {
        let encoder = JSONEncoder()
        return (try? encoder.encode(self)) ?? Data()
    }
}
