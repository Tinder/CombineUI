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
public struct GestureRecognizer<T: UIGestureRecognizer> {

    public var wrappedValue: T
    public var projectedValue: GestureRecognizerInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = GestureRecognizerInterface(gestureRecognizer: wrappedValue)
    }
}

extension Target where Self: UIGestureRecognizer {

    @preconcurrency
    @MainActor
    public func publisher(attachingTo view: UIView) -> AnyPublisher<Self, Never> {
        GestureRecognizerPublisher(gestureRecognizer: self, view: view).eraseToAnyPublisher()
    }
}
