//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
@propertyWrapper
public struct Stepper<T: UIStepper> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Double, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .valuePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UIStepper {

    @MainActor
    public func valuePublisher() -> AnyPublisher<Double, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.value)
            .prepend(value)
            .eraseToAnyPublisher()
    }
}
