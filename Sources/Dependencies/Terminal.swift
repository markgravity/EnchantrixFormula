//
//  Terminal.swift
//  EnchantrixFormula
//
//  Created by MarkG on 4/6/24.
//

import Foundation

@objc public protocol Terminal {

    @objc func run(
        _ cmd : String,
        at dir: URL?,
        onOuput: ((TerminalOutput) -> Void)?
    ) async throws
}

public extension Terminal {

    func run(
        _ cmd : String,
        at dir: URL? = nil,
        onOuput: ((TerminalOutput) -> Void)? = nil
    ) async throws {
        try await run(
            cmd,
            at: dir,
            onOuput: onOuput
        )
    }
}

@objc public class TerminalOutput: NSObject {

    public let isError: Bool
    public let content: String

    public init(isError: Bool, content: String) {
        self.isError = isError
        self.content = content
    }
}
