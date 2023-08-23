//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal final class GestureRecognizerSubscription
<
    T: UIGestureRecognizer,
    S: Subscriber
>
: Subscription where S.Input == T,
                     S.Failure == Never {

    private var subscriber: S?

    private weak var gestureRecognizer: T?
    private weak var view: UIView?

    internal init(subscriber: S, gestureRecognizer: T?, view: UIView?) {
        self.subscriber = subscriber
        self.gestureRecognizer = gestureRecognizer
        self.view = view
    }

    internal func request(_ demand: Subscribers.Demand) {
        guard subscriber != nil,
              let gestureRecognizer: T
        else { return }
        gestureRecognizer.addTarget(self, action: #selector(action))
        if gestureRecognizer.view !== view {
            gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
            view?.addGestureRecognizer(gestureRecognizer)
        }
    }

    internal func cancel() {
        subscriber = nil
        guard let gestureRecognizer: T
        else { return }
        gestureRecognizer.removeTarget(self, action: #selector(action))
        gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
    }

    @objc
    internal func action() {
        guard let gestureRecognizer: T
        else { return }
        _ = subscriber?.receive(gestureRecognizer)
    }

    deinit {
        cancel()
    }
}
