//
//  Queueable.swift
//  EnchantrixFormula
//
//  Created by MarkG on 5/6/24.
//

import Foundation
import Combine
import AppKit

public typealias TaskInit = (_ onOutput: @escaping (QueueableOutput) -> Void) -> Task<Void, Error>

public enum QueuedTaskStatus {

    case queued, running, success, error
}

public final class QueuedTask: ObservableObject, Identifiable, Equatable, Hashable {

    public let id: UUID = .init()
    public let name: String
    public let icon: NSImage?
    public let targetItem: TargetItem?

    let taskInit: TaskInit

    @Published public var output: [QueueableOutput] = []
    @Published public var status: QueuedTaskStatus = .queued

    public var isCompleted: Bool {
        status == .success || status == .error
    }

    public init(
        name: String,
        icon: NSImage?,
        targetItem: TargetItem?,
        taskInit: @escaping TaskInit
    ) {
        self.name = name
        self.icon = icon
        self.targetItem = targetItem
        self.taskInit = taskInit
    }

    public func run(completion: ( () -> Void)? = nil) {
        Task {
            await MainActor.run {
                status = .running
            }

            var hasError = false
            do {
                try await taskInit { [weak self] in
                    self?.output.append($0)
                }.value
            } catch {
                hasError = true
            }

            await MainActor.run { [hasError] in
                status = hasError ? .error : .success
                completion?()
            }
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: QueuedTask, rhs: QueuedTask) -> Bool {
        lhs.id == rhs.id
    }
}

public struct QueueableOutput: Identifiable, Hashable, Equatable {

    public let id: UUID = .init()
    public let isError: Bool
    public let content: String

    public init(isError: Bool, content: String) {
        self.isError = isError
        self.content = content
    }

    public init(output: CommandLineToolOutput) {
        isError = output.isError
        content = output.content
    }
}

public protocol Queueable {

    func queue(for target: Target) -> QueuedTask
}
