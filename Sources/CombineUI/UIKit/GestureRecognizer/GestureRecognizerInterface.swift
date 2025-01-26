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
