//
//  SafariTarget.swift
//  
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import Safari
import AppKit
import ScriptingBridge

public struct SafariProfile: Identifiable, Hashable {

    public let id: String
    public let name: String
}

public class SafariTarget: Target {

    public var profiles: [SafariProfile] {
        guard let element else { return [] }

        let regex: Regex<(Substring, Substring)> = try! Regex("New(.*)Window\\?isDefaultProfile=.*$")
        return element
            .children {
                $0.identifier.contains(regex)
            }
            .compactMap { element -> SafariProfile? in
                guard let match = element.identifier.firstMatch(of: regex)
                else { return nil }
                let id = String(match.output.1)

                return .init(
                    id: id,
                    name: id.removingPercentEncoding ?? ""
                )
            }
    }

    public func openURL(_ url: URL, at profile: SafariProfile) {
        guard let safari: SafariApplication = getAppScripting(),
              let windows = safari.windows?().get() as? [SafariWindow] else {
            return
        }

        safari.activate()
        if let window = windows.first(where: {
            $0.name?.starts(with: "\(profile.name) —") ?? false
                && $0.visible ?? false
        }) {
            window.setIndex?(0)
        } else {
            guard let profileButton = element?
                .firstChild(where: {
                    $0.identifier.starts(with: "New\(profile.id)Window")
                })
            else { return }
            profileButton.perform(kAXPressAction)
        }

        var url = url
        if url.scheme == nil {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.scheme = "http"
            url = components?.url ?? url
        }

        let script = NSAppleScript(source: """
tell application "Safari"
    set targetURL to "\(url.absoluteString)"
    set frontWindow to front window
    set urlFound to false

    repeat with t in tabs of frontWindow
        if URL of t is targetURL then
            set current tab of frontWindow to t
            set urlFound to true
            exit repeat
        end if
    end repeat

    if not urlFound then
        set newTab to (make new tab at end of tabs of frontWindow with properties {URL:targetURL})
        set current tab of frontWindow to newTab
    end if
end tell
""")
        var error: NSDictionary?
        _ = script?.executeAndReturnError(&error).stringValue
    }
}

public extension Target {

    static var safari: SafariTarget { .init(id: "com.apple.Safari") }
}

