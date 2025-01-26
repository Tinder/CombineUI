//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct ViewController<T: UIViewController> {

    public var wrappedValue: T
    public var projectedValue: ViewControllerInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = ViewControllerInterface(viewController: wrappedValue)
    }
}
