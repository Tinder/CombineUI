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

@preconcurrency
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

    @preconcurrency
    @MainActor
    public func publisher(for controlEvents: UIControl.Event) -> AnyPublisher<UIControl.Event, Never> {
        ControlPublisher(control: self, controlEvents: controlEvents).eraseToAnyPublisher()
    }
}
