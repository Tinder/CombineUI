//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

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

    public func valuePublisher() -> AnyPublisher<Float, Never> {
        publisher(for: .valueChanged)
            .weakPublisher(self)
            .map(\.value)
            .prepend(value)
            .eraseToAnyPublisher()
    }
}
