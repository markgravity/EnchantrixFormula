//
//  NSScreen.swift
//
//
//  Created by MarkG on 15/6/24.
//

import AppKit
import ApplicationServices

public typealias NSScreenID = String
public extension NSScreen {

    static var activeAtFrontmostApplication: NSScreen? {
        guard let app = NSWorkspace.shared.frontmostApplication
        else { return nil }

        let element = AXUIElementCreateApplication(app.processIdentifier)
        guard let window = element.focusedWindow else { return nil }
        return active(from: window)
    }

    static var activeAtMouse: NSScreen? {
        // Get the current mouse location in screen coordinates
        let mouseLocation = NSEvent.mouseLocation

        // Iterate through the available screens
        for screen in NSScreen.screens {
            // Check if the screen's frame contains the mouse location
            if screen.frame.contains(mouseLocation) {
                return screen
            }
        }

        // Return nil if no screen is found at the mouse location
        return nil
    }

    static var base: NSScreen? {
        screens.first { $0.frame.origin == .zero }
    }

    static func active(from element: AXUIElement) -> NSScreen? {
        var windowElement: AXUIElement? = element
        if element.role != "AXWindow" {
            windowElement = element.firstParent {
                $0.role == "AXWindow"
            }
        }
        guard var frame = windowElement?.rect else { return nil }
        frame = .init(
            origin: .init(x: frame.origin.x, y: abs(frame.origin.y)),
            size: frame.size
        )
        for screen in NSScreen.screens {
            if screen.frame.intersects(frame) {
                return screen
            }
        }

        return nil
    }

    var id: NSScreenID {
        "\(rotation) \(frame)"
    }

    var rotation: Double {
        let displayID = deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as! CGDirectDisplayID

        return CGDisplayRotation(displayID)
    }

    func convertPoint(_ point: CGPoint) -> CGPoint {
        var point = point
        // Get the current display ID for the screen

        // Adjust mouse coordinates based on the screen rotation
        switch rotation {
        case 90.0, 270.0:
            point.y = frame.width - point.y
        default:
            point.y = frame.height - abs(point.y)
        }

        return point
    }
}
