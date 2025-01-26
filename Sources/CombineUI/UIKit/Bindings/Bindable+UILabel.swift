//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UILabel {

    @preconcurrency
    @MainActor
    public var isEnabled: Binding<Bool> {
        Binding(self, for: \.isEnabled)
    }

    @preconcurrency
    @MainActor
    public var font: Binding<UIFont> {
        Binding(self, for: \.font)
    }

    @preconcurrency
    @MainActor
    public var textColor: Binding<UIColor> {
        Binding(self, for: \.textColor)
    }

    @preconcurrency
    @MainActor
    public var text: Binding<String> {
        Binding(self, for: \.text)
    }

    @preconcurrency
    @MainActor
    public var attributedText: Binding<AttributedString> {
        Binding(self) { $0.attributedText = NSAttributedString($1) }
    }
}
