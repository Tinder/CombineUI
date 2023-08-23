//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import Foundation

public struct UIScheduler: Scheduler {

    public typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType

    public enum SchedulerOptions {}

    public static let shared: UIScheduler = .init()

    private let main: DispatchQueue = .main

    public var now: SchedulerTimeType {
        main.now
    }

    public var minimumTolerance: SchedulerTimeType.Stride {
        main.minimumTolerance
    }

    private init() {}

    public func schedule(
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        if DispatchQueue.isMainQueue {
            action()
        } else {
            main.schedule(action)
        }
    }

    public func schedule(
        after date: SchedulerTimeType,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        main.schedule(after: date,
                      tolerance: tolerance,
                      options: nil,
                      action)
    }

    public func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        main.schedule(after: date,
                      interval: interval,
                      tolerance: tolerance,
                      options: nil,
                      action)
    }
}
