//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

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
