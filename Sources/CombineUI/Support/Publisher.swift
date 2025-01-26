//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
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
