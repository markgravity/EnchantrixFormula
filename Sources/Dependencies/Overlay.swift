//
//  Overlay.swift
//
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import SwiftUI

public typealias OverlayLevel = NSWindow.Level

public protocol Overlay {

    func showContext<Content>(
        at position: CGPoint,
        in screen: NSScreen,
        @ViewBuilder content: () -> Content
    ) where Content : View

    func dismissContext()

    func add<Content>(
        to screen: NSScreen,
        with id: String,
        level: OverlayLevel,
        @ViewBuilder content: () -> Content
    ) where Content : View

    func remove(for id: String)

    func orderFront(of screens: [NSScreen], for id: String)

    func orderOut(of screens: [NSScreen], for id: String)

    func changeLevel(
        _ level: OverlayLevel,
        for id: String,
        in screens: [NSScreen]
    )
}

public extension Overlay {

    func orderFront(of screens: [NSScreen] = NSScreen.screens, for id: String) {
        orderFront(of: screens, for: id)
    }

    func orderOut(of screens: [NSScreen] = NSScreen.screens, for id: String) {
        orderOut(of: screens, for: id)
    }

    func orderFront(of screen: NSScreen, for id: String) {
        orderFront(of: [screen], for: id)
    }

    func orderOut(of screen: NSScreen, for id: String) {
        orderOut(of: [screen], for: id)
    }

    func changeLevel(
        _ level: OverlayLevel,
        for id: String,
        in screens: [NSScreen] = NSScreen.screens
    ) {
        changeLevel(level, for: id, in: screens)
    }

    func changeLevel(
        _ level: OverlayLevel,
        for id: String,
        in screen: NSScreen
    ) {
        changeLevel(level, for: id, in: [screen])
    }
}
