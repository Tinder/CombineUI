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

    @preconcurrency
    @MainActor
    public func currentPagePublisher() -> AnyPublisher<Int, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.currentPage)
            .prepend(currentPage)
            .eraseToAnyPublisher()
    }
}
