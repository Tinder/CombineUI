//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@propertyWrapper
public struct SegmentedControl<T: UISegmentedControl> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Int, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .selectedSegmentIndexPublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UISegmentedControl {

    public func selectedSegmentIndexPublisher() -> AnyPublisher<Int, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.selectedSegmentIndex)
            .prepend(selectedSegmentIndex)
            .eraseToAnyPublisher()
    }
}
