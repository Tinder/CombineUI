//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

public protocol GestureRecognizable {}

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

extension GestureRecognizable where Self: UIGestureRecognizer {

    @MainActor
    public func publisher(attachingTo view: UIView) -> AnyPublisher<Self, Never> {
        GestureRecognizerPublisher(gestureRecognizer: self, view: view).eraseToAnyPublisher()
    }
}

extension UIGestureRecognizer: GestureRecognizable {}
