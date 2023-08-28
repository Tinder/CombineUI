//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIButton {

    @MainActor
    public func title(for state: UIControl.State) -> Binding<String> {
        Binding(self) { $0.setTitle($1, for: state) }
    }

    @MainActor
    public func attributedTitle(for state: UIControl.State) -> Binding<NSAttributedString> {
        Binding(self) { $0.setAttributedTitle($1, for: state) }
    }
}
