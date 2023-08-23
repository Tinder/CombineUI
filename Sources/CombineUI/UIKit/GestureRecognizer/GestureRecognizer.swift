//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

// swiftlint:disable:next type_name
public protocol _GestureRecognizer {}

@propertyWrapper
public struct GestureRecognizer<T: UIGestureRecognizer> {

    public var wrappedValue: T
    public var projectedValue: GestureRecognizerInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = GestureRecognizerInterface(gestureRecognizer: wrappedValue)
    }
}

extension UIGestureRecognizer: _GestureRecognizer {}

extension _GestureRecognizer where Self: UIGestureRecognizer {

    public func publisher(attachingTo view: UIView) -> AnyPublisher<Self, Never> {
        GestureRecognizerPublisher(gestureRecognizer: self, view: view).eraseToAnyPublisher()
    }
}
