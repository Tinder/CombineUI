//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

public protocol Target: AnyObject {}

extension Target {

    public var bindable: Bindable<Self> {
        Bindable(self)
    }
}
