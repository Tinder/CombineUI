//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct ScrollView<T: UIScrollView> {

    public var wrappedValue: T
    public var projectedValue: ScrollViewInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = ScrollViewInterface(scrollView: wrappedValue)
    }
}
