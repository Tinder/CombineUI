//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
@propertyWrapper
public struct Slider<T: UISlider> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Float, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .valuePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UISlider {

    @MainActor
    public func valuePublisher() -> AnyPublisher<Float, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.value)
            .prepend(value)
            .eraseToAnyPublisher()
    }
}
