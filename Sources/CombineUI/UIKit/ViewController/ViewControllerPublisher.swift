//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal struct ViewControllerPublisher<T: UIViewController>: Publisher {

    internal typealias Output = ViewControllerLifecycleEvent
    internal typealias Failure = Never

    private weak var viewController: T?

    internal init(viewController: T) {
        self.viewController = viewController
    }

    internal func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        subscriber.receive(subscription: ViewControllerSubscription(
            subscriber: subscriber,
            viewController: viewController
        ))
    }
}
