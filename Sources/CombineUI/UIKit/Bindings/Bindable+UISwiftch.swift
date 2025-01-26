//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UISwitch {

    @preconcurrency
    @MainActor
    public var onTintColor: Binding<UIColor> {
        Binding(self, for: \.onTintColor)
    }

    @preconcurrency
    @MainActor
    public var thumbTintColor: Binding<UIColor> {
        Binding(self, for: \.thumbTintColor)
    }

    @preconcurrency
    @MainActor
    public var isOn: Binding<Bool> {
        Binding(self, for: \.isOn)
    }

    @preconcurrency
    @MainActor
    public func isOn(animated: Bool) -> Binding<Bool> {
        Binding(self) { $0.setOn($1, animated: animated) }
    }
}
