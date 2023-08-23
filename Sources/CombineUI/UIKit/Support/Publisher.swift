//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine

extension Publisher {

    internal func voidPublisher() -> Publishers.Map<Self, Void> {
        map { _ in () }
    }

    internal func weakPublisher<T: AnyObject>(_ object: T) -> Publishers.CompactMap<Self, T> {
        compactMap { [weak object] _ in object }
    }
}
