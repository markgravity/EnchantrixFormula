//
//  TargetableItem.swift
//  EnchantrixFormula
//
//  Created by MarkG on 10/6/24.
//

import Foundation
import AppKit

public struct TargetItem: Identifiable, Hashable, Equatable {

    public var id: String { name }
    public let name: String
    public let icon: NSImage

    public init(filePath: URL) {
        icon = NSWorkspace.shared.icon(forFile: filePath.path)
        name = filePath.pathComponents.last ?? ""
    }

    public init(name: String, icon: NSImage) {
        self.name = name
        self.icon = icon
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public protocol TargetableItem {

    func getTargetItem(on target: Target) -> TargetItem?
}
