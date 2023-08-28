//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UILabel {

    @MainActor public var isEnabled: Binding<Bool> {
        Binding(self, for: \.isEnabled)
    }

    @MainActor public var text: Binding<String> {
        Binding(self, for: \.text)
    }

    @MainActor public var attributedText: Binding<NSAttributedString> {
        Binding(self, for: \.attributedText)
    }
}
