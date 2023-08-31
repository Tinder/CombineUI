//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct SearchBar<T: UISearchBar> {

    public var wrappedValue: T
    public var projectedValue: SearchBarInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = SearchBarInterface(searchBar: wrappedValue)
    }
}
