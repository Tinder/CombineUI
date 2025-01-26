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

internal struct GestureRecognizerPublisher<T: UIGestureRecognizer>: Publisher {

    internal typealias Output = T
    internal typealias Failure = Never

    private weak var gestureRecognizer: T?
    private weak var view: UIView?

    internal init(gestureRecognizer: T, view: UIView) {
        self.gestureRecognizer = gestureRecognizer
        self.view = view
    }

    internal func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        subscriber.receive(subscription: GestureRecognizerSubscription(
            subscriber: subscriber,
            gestureRecognizer: gestureRecognizer,
            view: view
        ))
    }
}
