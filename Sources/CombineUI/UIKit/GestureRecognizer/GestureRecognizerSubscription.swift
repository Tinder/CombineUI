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
: NSObject, Subscription where S.Input == T,
                               S.Failure == Never {

    private var subscriber: S?

    private weak var gestureRecognizer: T?
    private weak var view: UIView?

    internal init(subscriber: S, gestureRecognizer: T?, view: UIView?) {
        self.subscriber = subscriber
        self.gestureRecognizer = gestureRecognizer
        self.view = view
    }

    // swiftlint:disable:next unused_parameter
    internal func request(_ demand: Subscribers.Demand) {
        perform(#selector(start), on: .main, with: nil, waitUntilDone: true)
    }

    internal func cancel() {
        subscriber = nil
        perform(#selector(stop), on: .main, with: nil, waitUntilDone: true)
    }

    @objc
    internal func action() {
        guard let gestureRecognizer: T
        else { return }
        _ = subscriber?.receive(gestureRecognizer)
    }

    @objc
    @preconcurrency
    @MainActor
    private func start() {
        guard subscriber != nil,
              let gestureRecognizer: T
        else { return }
        gestureRecognizer.addTarget(self, action: #selector(action))
        if gestureRecognizer.view !== view {
            gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
            view?.addGestureRecognizer(gestureRecognizer)
        }
    }

    @objc
    @preconcurrency
    @MainActor
    private func stop() {
        guard let gestureRecognizer: T
        else { return }
        gestureRecognizer.removeTarget(self, action: #selector(action))
        gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
    }

    deinit {
        cancel()
    }
}
