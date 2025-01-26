//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
