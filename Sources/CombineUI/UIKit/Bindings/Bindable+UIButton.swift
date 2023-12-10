//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIButton {

    @preconcurrency
    @MainActor
    public func title(for state: UIControl.State) -> Binding<String> {
        Binding(self) { $0.setTitle($1, for: state) }
    }

    @preconcurrency
    @MainActor
    public func attributedTitle(for state: UIControl.State) -> Binding<AttributedString> {
        Binding(self) { $0.setAttributedTitle(NSAttributedString($1), for: state) }
    }
}
