//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UITextView {

    @preconcurrency
    @MainActor
    public var isEditable: Binding<Bool> {
        Binding(self, for: \.isEditable)
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
    public var textAlignment: Binding<NSTextAlignment> {
        Binding(self, for: \.textAlignment)
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
