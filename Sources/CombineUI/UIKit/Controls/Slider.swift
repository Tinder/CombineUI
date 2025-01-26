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

    @preconcurrency
    @MainActor
    public func valuePublisher() -> AnyPublisher<Float, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.value)
            .prepend(value)
            .eraseToAnyPublisher()
    }
}
