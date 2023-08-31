//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UITextField {

    @preconcurrency @MainActor public var text: Binding<String> {
        Binding(self, for: \.text)
    }

    @preconcurrency @MainActor public var attributedText: Binding<NSAttributedString> {
        Binding(self, for: \.attributedText)
    }
}
