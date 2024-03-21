//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct TextView<T: UITextView> {

    public var wrappedValue: T
    public var projectedValue: TextViewInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = TextViewInterface(textView: wrappedValue)
    }
}
