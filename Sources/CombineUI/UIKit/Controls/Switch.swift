//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

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

    @MainActor
    public func isOnPublisher() -> AnyPublisher<Bool, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.isOn)
            .prepend(isOn)
            .eraseToAnyPublisher()
    }
}
