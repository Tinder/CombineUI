//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal final class ControlSubscription
<
    T: UIControl,
    S: Subscriber
>
: NSObject, Subscription where S.Input == UIControl.Event,
                               S.Failure == Never {

    private var subscriber: S?

    private weak var control: T?
    private let controlEvents: UIControl.Event

    internal init(subscriber: S, control: T?, controlEvents: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        self.controlEvents = controlEvents
    }

    internal func request(_ demand: Subscribers.Demand) {
        perform(#selector(start), on: .main, with: nil, waitUntilDone: true)
    }

    internal func cancel() {
        subscriber = nil
        perform(#selector(stop), on: .main, with: nil, waitUntilDone: true)
    }

    @objc
    internal func touchDown() {
        guard controlEvents.contains(.touchDown)
        else { return }
        _ = subscriber?.receive(.touchDown)
    }

    @objc
    internal func touchDownRepeat() {
        guard controlEvents.contains(.touchDownRepeat)
        else { return }
        _ = subscriber?.receive(.touchDownRepeat)
    }

    @objc
    internal func touchDragInside() {
        guard controlEvents.contains(.touchDragInside)
        else { return }
        _ = subscriber?.receive(.touchDragInside)
    }

    @objc
    internal func touchDragOutside() {
        guard controlEvents.contains(.touchDragOutside)
        else { return }
        _ = subscriber?.receive(.touchDragOutside)
    }

    @objc
    internal func touchDragEnter() {
        guard controlEvents.contains(.touchDragEnter)
        else { return }
        _ = subscriber?.receive(.touchDragEnter)
    }

    @objc
    internal func touchDragExit() {
        guard controlEvents.contains(.touchDragExit)
        else { return }
        _ = subscriber?.receive(.touchDragExit)
    }

    @objc
    internal func touchUpInside() {
        guard controlEvents.contains(.touchUpInside)
        else { return }
        _ = subscriber?.receive(.touchUpInside)
    }

    @objc
    internal func touchUpOutside() {
        guard controlEvents.contains(.touchUpOutside)
        else { return }
        _ = subscriber?.receive(.touchUpOutside)
    }

    @objc
    internal func touchCancel() {
        guard controlEvents.contains(.touchCancel)
        else { return }
        _ = subscriber?.receive(.touchCancel)
    }

    @objc
    internal func valueChanged() {
        guard controlEvents.contains(.valueChanged)
        else { return }
        _ = subscriber?.receive(.valueChanged)
    }

    @objc
    internal func menuActionTriggered() {
        guard controlEvents.contains(.menuActionTriggered)
        else { return }
        _ = subscriber?.receive(.menuActionTriggered)
    }

    @objc
    internal func primaryActionTriggered() {
        guard controlEvents.contains(.primaryActionTriggered)
        else { return }
        _ = subscriber?.receive(.primaryActionTriggered)
    }

    @objc
    internal func editingDidBegin() {
        guard controlEvents.contains(.editingDidBegin)
        else { return }
        _ = subscriber?.receive(.editingDidBegin)
    }

    @objc
    internal func editingChanged() {
        guard controlEvents.contains(.editingChanged)
        else { return }
        _ = subscriber?.receive(.editingChanged)
    }

    @objc
    internal func editingDidEnd() {
        guard controlEvents.contains(.editingDidEnd)
        else { return }
        _ = subscriber?.receive(.editingDidEnd)
    }

    @objc
    internal func editingDidEndOnExit() {
        guard controlEvents.contains(.editingDidEndOnExit)
        else { return }
        _ = subscriber?.receive(.editingDidEndOnExit)
    }

    @objc
    @preconcurrency
    @MainActor
    private func start() { // swiftlint:disable:this function_body_length cyclomatic_complexity
        guard subscriber != nil,
              let control: T
        else { return }
        if controlEvents.contains(.touchDown) {
            control.addTarget(self, action: #selector(touchDown), for: .touchDown)
        }
        if controlEvents.contains(.touchDownRepeat) {
            control.addTarget(self, action: #selector(touchDownRepeat), for: .touchDownRepeat)
        }
        if controlEvents.contains(.touchDragInside) {
            control.addTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
        }
        if controlEvents.contains(.touchDragOutside) {
            control.addTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        }
        if controlEvents.contains(.touchDragEnter) {
            control.addTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        }
        if controlEvents.contains(.touchDragExit) {
            control.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        }
        if controlEvents.contains(.touchUpInside) {
            control.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        }
        if controlEvents.contains(.touchUpOutside) {
            control.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        }
        if controlEvents.contains(.touchCancel) {
            control.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        }
        if controlEvents.contains(.valueChanged) {
            control.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }
        if controlEvents.contains(.menuActionTriggered) {
            control.addTarget(self, action: #selector(menuActionTriggered), for: .menuActionTriggered)
        }
        if controlEvents.contains(.primaryActionTriggered) {
            control.addTarget(self, action: #selector(primaryActionTriggered), for: .primaryActionTriggered)
        }
        if controlEvents.contains(.editingDidBegin) {
            control.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        }
        if controlEvents.contains(.editingChanged) {
            control.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        if controlEvents.contains(.editingDidEnd) {
            control.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        }
        if controlEvents.contains(.editingDidEndOnExit) {
            control.addTarget(self, action: #selector(editingDidEndOnExit), for: .editingDidEndOnExit)
        }
    }

    @objc
    @preconcurrency
    @MainActor
    private func stop() { // swiftlint:disable:this cyclomatic_complexity
        guard let control: T
        else { return }
        if controlEvents.contains(.touchDown) {
            control.removeTarget(self, action: #selector(touchDown), for: .touchDown)
        }
        if controlEvents.contains(.touchDownRepeat) {
            control.removeTarget(self, action: #selector(touchDownRepeat), for: .touchDownRepeat)
        }
        if controlEvents.contains(.touchDragInside) {
            control.removeTarget(self, action: #selector(touchDragInside), for: .touchDragInside)
        }
        if controlEvents.contains(.touchDragOutside) {
            control.removeTarget(self, action: #selector(touchDragOutside), for: .touchDragOutside)
        }
        if controlEvents.contains(.touchDragEnter) {
            control.removeTarget(self, action: #selector(touchDragEnter), for: .touchDragEnter)
        }
        if controlEvents.contains(.touchDragExit) {
            control.removeTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        }
        if controlEvents.contains(.touchUpInside) {
            control.removeTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        }
        if controlEvents.contains(.touchUpOutside) {
            control.removeTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
        }
        if controlEvents.contains(.touchCancel) {
            control.removeTarget(self, action: #selector(touchCancel), for: .touchCancel)
        }
        if controlEvents.contains(.valueChanged) {
            control.removeTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }
        if controlEvents.contains(.menuActionTriggered) {
            control.removeTarget(self, action: #selector(menuActionTriggered), for: .menuActionTriggered)
        }
        if controlEvents.contains(.primaryActionTriggered) {
            control.removeTarget(self, action: #selector(primaryActionTriggered), for: .primaryActionTriggered)
        }
        if controlEvents.contains(.editingDidBegin) {
            control.removeTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        }
        if controlEvents.contains(.editingChanged) {
            control.removeTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        if controlEvents.contains(.editingDidEnd) {
            control.removeTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        }
        if controlEvents.contains(.editingDidEndOnExit) {
            control.removeTarget(self, action: #selector(editingDidEndOnExit), for: .editingDidEndOnExit)
        }
    }

    deinit {
        cancel()
    }
}
