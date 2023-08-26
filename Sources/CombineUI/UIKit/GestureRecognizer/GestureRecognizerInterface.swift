//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
public struct GestureRecognizerInterface<T: UIGestureRecognizer> {

    private let gestureRecognizer: T

    internal init(gestureRecognizer: T) {
        self.gestureRecognizer = gestureRecognizer
    }

    public func attaching(to view: UIView) -> AnyPublisher<T, Never> {
        gestureRecognizer
            .publisher(attachingTo: view)
            .eraseToAnyPublisher()
    }
}
