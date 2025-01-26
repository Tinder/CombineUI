//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UITextField {

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
    public var textAlignment: Binding<NSTextAlignment> {
        Binding(self, for: \.textAlignment)
    }

    @preconcurrency
    @MainActor
    public var placeholder: Binding<String> {
        Binding(self, for: \.placeholder)
    }

    @preconcurrency
    @MainActor
    public var attributedPlaceholder: Binding<AttributedString> {
        Binding(self) { $0.attributedPlaceholder = NSAttributedString($1) }
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
