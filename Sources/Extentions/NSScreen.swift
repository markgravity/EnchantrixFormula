//
//  NSScreen.swift
//
//
//  Created by MarkG on 15/6/24.
//

import AppKit
import ApplicationServices

public extension NSScreen {

    static var active: NSScreen? {
        guard let app = NSWorkspace.shared.frontmostApplication
        else { return nil }

        let element = AXUIElementCreateApplication(app.processIdentifier)
        guard let window = element.focusedWindow else { return nil }
        return active(from: window)
    }

    static func active(from element: AXUIElement) -> NSScreen? {
        var windowElement: AXUIElement? = element
        if element.role != "AXWindow" {
            windowElement = element.firstParent {
                $0.role == "AXWindow"
            }
        }
        guard let frame = windowElement?.rect else { return nil }

        for screen in NSScreen.screens {
            if screen.frame.intersects(frame) {
                return screen
            }
        }

        return nil
    }
}
