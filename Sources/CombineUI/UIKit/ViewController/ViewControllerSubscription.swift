//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import UIKit

internal final class ViewControllerSubscription
<
    T: UIViewController,
    S: Subscriber
>
: NSObject, Subscription, LifecycleViewControllerDelegate where S.Input == ViewControllerLifecycleEvent,
                                                                S.Failure == Never {

    private var subscriber: S?

    private weak var viewController: T?

    @preconcurrency
    @MainActor
    private lazy var lifecycleViewController: LifecycleViewController = {
        let lifecycleViewController: LifecycleViewController = .init()
        lifecycleViewController.delegate = self
        return lifecycleViewController
    }()

    internal init(subscriber: S, viewController: T?) {
        self.subscriber = subscriber
        self.viewController = viewController
    }

    // swiftlint:disable:next unused_parameter
    internal func request(_ demand: Subscribers.Demand) {
        perform(#selector(start), on: .main, with: nil, waitUntilDone: true)
    }

    internal func cancel() {
        subscriber = nil
        perform(#selector(stop), on: .main, with: nil, waitUntilDone: true)
    }

    internal func lifecycle(_ event: ViewControllerLifecycleEvent) {
        _ = subscriber?.receive(event)
    }

    @objc
    @preconcurrency
    @MainActor
    private func start() {
        guard subscriber != nil,
              let viewController: T
        else { return }
        if !viewController.children.contains(lifecycleViewController) {
            viewController.contain(lifecycleViewController)
        }
    }

    @objc
    @preconcurrency
    @MainActor
    private func stop() {
        guard let viewController: T
        else { return }
        viewController.uncontain(lifecycleViewController)
    }

    deinit {
        cancel()
    }
}
