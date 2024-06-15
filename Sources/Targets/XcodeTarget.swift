//
//  XcodeTarget.swift
//  
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import ApplicationServices

public class XcodeTarget: Target {

    public var projectName: String? {
        element?.focusedWindow?.title
            .components(separatedBy: " — ")
            .first
    }

    public var documentURL: URL? {
        guard let windowElement = element?.focusedWindow,
              let document = windowElement.document
        else { return nil }

        return URL(string: document)
    }

    public var projectURL: URL? {
        guard let windowElement = element?.focusedWindow else {
            return nil
        }

        for child in windowElement.children {
            if child.description.starts(with: "/"), child.description.count > 1 {
                let path = child.description
                let trimmedNewLine = path.trimmingCharacters(in: .newlines)
                let url = URL(fileURLWithPath: trimmedNewLine)
                return url.deletingLastPathComponent()
            }
        }

        return nil
    }

    public var sourceEditor: AXUIElement? {
        element?.firstChild { $0.isSourceEditor }
    }
}

public extension Target {

    static var xcode: XcodeTarget { XcodeTarget(id: "com.apple.dt.Xcode") }
}
