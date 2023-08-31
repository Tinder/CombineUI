//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UILabel {

    @preconcurrency @MainActor public var isEnabled: Binding<Bool> {
        Binding(self, for: \.isEnabled)
    }

    @preconcurrency @MainActor public var text: Binding<String> {
        Binding(self, for: \.text)
    }

    @preconcurrency @MainActor public var attributedText: Binding<NSAttributedString> {
        Binding(self, for: \.attributedText)
    }
}
