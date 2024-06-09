//
//  Target.swift
//  EnchantrixFormula
//
//  Created by MarkG on 6/6/24.
//

import Foundation
import AppKit
import ApplicationServices
import ScriptingBridge

public struct Target: Hashable, Identifiable {

    public let id: String

    public var runningApp: NSRunningApplication? {
        NSRunningApplication.runningApplications(withBundleIdentifier: id)
            .first
    }

    public var element: AXUIElement? {
        guard let runningApp else { return nil }
        return AXUIElementCreateApplication(runningApp.processIdentifier)
    }

    public var url: URL? {
        NSWorkspace.shared.urlForApplication(withBundleIdentifier: id)
    }

    public var bundle: Bundle? {
        guard let url else {
            return nil
        }

        return Bundle(url: url)
    }

    public var icon: NSImage? {
        guard let url,
              let iconFile = bundle?.infoDictionary?["CFBundleIconFile"] as? String else {
            return nil
        }

        let iconPath = url.appendingPathComponent("Contents/Resources/\(iconFile).icns").path
        return NSImage(contentsOfFile: iconPath)
    }

    public var name: String {
        guard let bundle else { return id }

        let name = bundle.infoDictionary?["CFBundleDisplayName"] as? String ?? bundle.infoDictionary?["CFBundleName"] as? String
        return name ?? id
    }

    public init(id: String) {
        self.id = id
    }

    public func getAppScripting<T: SBApplication>() -> T? {
        SBApplication(bundleIdentifier: id) as? T
    }
}
