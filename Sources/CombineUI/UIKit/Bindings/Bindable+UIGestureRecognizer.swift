//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIGestureRecognizer {

    @preconcurrency
    @MainActor
    public var isEnabled: Binding<Bool> {
        Binding(self, for: \.isEnabled)
    }
}
