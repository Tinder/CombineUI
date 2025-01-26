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
public struct Switch<T: UISwitch> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Bool, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .isOnPublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UISwitch {

    @preconcurrency
    @MainActor
    public func isOnPublisher() -> AnyPublisher<Bool, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.isOn)
            .prepend(isOn)
            .eraseToAnyPublisher()
    }
}
