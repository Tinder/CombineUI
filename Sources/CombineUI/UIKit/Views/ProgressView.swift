//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct ProgressView<T: UIProgressView> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Float, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .progressPublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UIProgressView {

    @preconcurrency
    @MainActor
    public func progressPublisher() -> AnyPublisher<Float, Never> {
        publisher(for: \.progress).eraseToAnyPublisher()
    }
}
