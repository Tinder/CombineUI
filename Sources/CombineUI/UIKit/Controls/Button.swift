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
            .replaceOutput(with: Void())
            .eraseToAnyPublisher()
    }
}
