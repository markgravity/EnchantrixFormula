//
//  VisualEffect.swift
//
//
//  Created by MarkG on 16/6/24.
//

import SwiftUI

public struct VisualEffect: NSViewRepresentable {

    public init() {}

    public func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    public func updateNSView(_ nsView: NSView, context: Context) { }
}
