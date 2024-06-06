//
//  Queueable.swift
//  EnchantrixFormula
//
//  Created by MarkG on 5/6/24.
//

import Foundation
import Combine

public typealias TaskInit = (_ onOutput: @escaping (QueueableOutput) -> Void) -> Task<Void, Never>

public final class QueuedTask: ObservableObject, Identifiable, Equatable {

    public let id: UUID = .init()
    public let name: String
    public let icon: NSImage?

    let taskInit: TaskInit

    @Published public var output: [QueueableOutput] = []
    @Published public var isRunning: Bool = false

    public init(
        name: String,
        icon: NSImage?,
        taskInit: @escaping TaskInit
    ) {
        self.name = name
        self.icon = icon
        self.taskInit = taskInit
    }

    public func run(completion: @escaping () -> Void) {
        Task {
            await MainActor.run {
                isRunning = true
            }

            await taskInit { [weak self] in
                self?.output.append($0)
            }.value

            await MainActor.run {
                isRunning = false
                completion()
            }
        }
    }

    public static func == (lhs: QueuedTask, rhs: QueuedTask) -> Bool {
        lhs.id == rhs.id
    }
}

public struct QueueableOutput: Hashable, Equatable {

    public let isError: Bool
    public let content: String

    public init(isError: Bool, content: String) {
        self.isError = isError
        self.content = content
    }

    public init(output: TerminalOutput) {
        isError = output.isError
        content = output.content
    }
}

public protocol Queueable {

    func queue() -> QueuedTask
}
