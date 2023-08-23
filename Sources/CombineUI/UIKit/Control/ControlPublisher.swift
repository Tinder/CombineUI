//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal struct ControlPublisher<T: UIControl>: Publisher {

    internal typealias Output = UIControl.Event
    internal typealias Failure = Never

    private weak var control: T?
    private let controlEvents: UIControl.Event

    internal init(control: T, controlEvents: UIControl.Event) {
        self.control = control
        self.controlEvents = controlEvents
    }

    internal func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        subscriber.receive(subscription: ControlSubscription(
            subscriber: subscriber,
            control: control,
            controlEvents: controlEvents
        ))
    }
}
