//
//  FinderTarget.swift
//
//
//  Created by MarkG on 15/6/24.
//

import Foundation
import Finder
import AppKit

public class FinderTarget: Target {

    public var selectedFolderURL: URL? {
        guard let finder: FinderApplication = getAppScripting() else {
            return nil
        }

        guard let result = finder.selection else {
            return nil
        }

        var itemURL: URL!

        if let files = result.get() as? [FinderFile],
           let url = URL(string: files.first?.URL ?? "") {
            itemURL = url
            if !url.hasDirectoryPath {
                itemURL = url.deletingLastPathComponent()
            }
        } else {
            guard let windows = finder.windows?().get() as? [FinderFinderWindow],
                  let window = windows.first,
                  let target = window.target as FinderItem?,
                  let url = URL(string: target.URL ?? "") else {
                return nil
            }
            itemURL = url
        }

        return itemURL
    }

    public func reveal(in url: URL) {
        if url.hasDirectoryPath {
            NSWorkspace.shared.selectFile(
                nil,
                inFileViewerRootedAtPath: url.path
            )
        } else {
            NSWorkspace.shared.activateFileViewerSelecting([url])
        }
    }
}

public extension Target {

    static var finder: FinderTarget { .init(id: "com.apple.finder") }
}
