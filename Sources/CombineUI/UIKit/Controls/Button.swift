//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct Button<T: UIButton> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Void, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .tapPublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UIButton {

    @preconcurrency
    @MainActor
    public func tapPublisher() -> AnyPublisher<Void, Never> {
        publisher(for: .primaryActionTriggered)
            .voidPublisher()
            .eraseToAnyPublisher()
    }
}
