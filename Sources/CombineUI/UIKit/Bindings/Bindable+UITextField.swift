//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UITextField {

    @preconcurrency @MainActor public var text: Binding<String> {
        Binding(self, for: \.text)
    }

    @preconcurrency @MainActor public var attributedText: Binding<AttributedString> {
        Binding(self) { $0.attributedText = NSAttributedString($1) }
    }
}
