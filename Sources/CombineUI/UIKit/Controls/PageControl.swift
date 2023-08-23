//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@propertyWrapper
public struct PageControl<T: UIPageControl> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Int, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .currentPagePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UIPageControl {

    public func currentPagePublisher() -> AnyPublisher<Int, Never> {
        publisher(for: .valueChanged)
            .weakPublisher(self)
            .map(\.currentPage)
            .prepend(currentPage)
            .eraseToAnyPublisher()
    }
}
