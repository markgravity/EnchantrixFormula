//
//  SafariTarget.swift
//  
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import Safari
import AppKit

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
        }) {
            window.setVisible?(true)
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

        NSWorkspace.shared.open(url)
    }
}

public extension Target {

    static var safari: SafariTarget { .init(id: "com.apple.Safari") }
}
