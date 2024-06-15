//
//  CommandLineTool.swift
//  EnchantrixFormula
//
//  Created by MarkG on 4/6/24.
//

import Foundation

@objc public protocol CommandLineTool {

    @objc func run(
        _ cmd : String,
        at dir: URL?,
        onOutput: ((CommandLineToolOutput) -> Void)?
    ) async throws
}

public extension CommandLineTool {

    func run(
        _ cmd : String,
        at dir: URL? = nil,
        onOutput: ((CommandLineToolOutput) -> Void)? = nil
    ) async throws {
        try await run(
            cmd,
            at: dir,
            onOutput: onOutput
        )
    }
}

@objc public class CommandLineToolOutput: NSObject {

    public let isError: Bool
    public let content: String

    public init(isError: Bool, content: String) {
        self.isError = isError
        self.content = content
    }
}
