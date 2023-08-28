//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine

extension Publisher {

    internal func voidPublisher() -> Publishers.Map<Self, Void> {
        map { _ in () }
    }

    internal func compactMap<T: Target>(_ bindable: Bindable<T>) -> Publishers.CompactMap<Self, T> {
        compactMap { _ in bindable.target }
    }
}
