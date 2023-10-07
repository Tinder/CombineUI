//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine

extension Publisher {

    internal func replaceOutput<T>(with output: T) -> Publishers.Map<Self, T> {
        map { _ in output }
    }

    internal func compactMap<T: Target>(_ bindable: Bindable<T>) -> Publishers.CompactMap<Self, T> {
        compactMap { _ in bindable.target }
    }
}
