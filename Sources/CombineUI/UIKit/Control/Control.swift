//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
@propertyWrapper
public struct Control<T: UIControl> {

    public var wrappedValue: T
    public var projectedValue: ControlInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = ControlInterface(control: wrappedValue)
    }
}

extension UIControl {

    @MainActor
    public func publisher(for controlEvents: UIControl.Event) -> AnyPublisher<UIControl.Event, Never> {
        ControlPublisher(control: self, controlEvents: controlEvents).eraseToAnyPublisher()
    }
}
