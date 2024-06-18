//
//  OverlayController.swift
//  
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import SwiftUI

public protocol OverlayController {

    func show<Content>(
        at position: CGPoint,
        in screen: NSScreen,
        @ViewBuilder content: () -> Content
    ) where Content: View
    func hide()

}
