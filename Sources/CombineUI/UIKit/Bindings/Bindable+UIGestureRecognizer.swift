//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIGestureRecognizer {

    @preconcurrency
    @MainActor
    public var isEnabled: Binding<Bool> {
        Binding(self, for: \.isEnabled)
    }
}
