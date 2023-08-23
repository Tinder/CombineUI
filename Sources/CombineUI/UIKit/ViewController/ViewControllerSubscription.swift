//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal final class ViewControllerSubscription
<
    T: UIViewController,
    S: Subscriber
>
: Subscription, LifecycleViewControllerDelegate where S.Input == ViewControllerLifecycleEvent,
                                                      S.Failure == Never {

    private var subscriber: S?

    private weak var viewController: T?

    private lazy var lifecycleViewController: LifecycleViewController = {
        let lifecycleViewController: LifecycleViewController = .init()
        lifecycleViewController.delegate = self
        return lifecycleViewController
    }()

    internal init(subscriber: S, viewController: T?) {
        self.subscriber = subscriber
        self.viewController = viewController
    }

    internal func request(_ demand: Subscribers.Demand) {
        guard subscriber != nil,
              let viewController: T
        else { return }
        if !viewController.children.contains(lifecycleViewController) {
            viewController.contain(lifecycleViewController)
        }
    }

    internal func cancel() {
        subscriber = nil
        guard let viewController: T
        else { return }
        viewController.uncontain(lifecycleViewController)
    }

    internal func lifecycle(_ event: ViewControllerLifecycleEvent) {
        _ = subscriber?.receive(event)
    }

    deinit {
        cancel()
    }
}
